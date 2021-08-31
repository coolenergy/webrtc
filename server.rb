require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/json'
require 'rack/contrib'
require 'twilio-ruby'

class VideoApp < Sinatra::Base
  use Rack::JSONBodyParser

  # Reload the server when you change code in this file
  configure :development do
    register Sinatra::Reloader
  end

  get '/' do
    send_file File.join(settings.public_folder, 'index.html')
  end

  post '/token' do
    # Get the user's identity and the room name from the request
    @identity = params['identity']
    @room_name = params['room']

    # Handle error if no identity was passed into the request
    json status: 400, error: 'No identity in request' if @identity.nil?

    twilio_account_sid = ENV['TWILIO_ACCOUNT_SID']
    twilio_api_key_sid = ENV['TWILIO_API_KEY_SID']
    twilio_api_key_secret = ENV['TWILIO_API_KEY_SECRET']

    # Set up the Twilio Client
    @client = Twilio::REST::Client.new twilio_api_key_sid, twilio_api_key_secret

    # Check whether the room you want to create exists already
    room_list = @client.video.rooms.list(unique_name: @room_name)
    room = room_list.find { |room| room.unique_name == @room_name }

    # If the room doesn't exist already, create it
    if room.nil?
      room = @client.video.rooms.create(
        type: 'go',
        unique_name: @room_name
      )
    end

    # Create an access token
    token = Twilio::JWT::AccessToken.new(twilio_account_sid, twilio_api_key_sid, twilio_api_key_secret, [], identity: @identity);

    # Create Video grant for your token
    grant = Twilio::JWT::AccessToken::VideoGrant.new
    grant.room = @room_name
    token.add_grant(grant)

    # Generate and return the token as a JSON response
    json status: 200, token: token.to_jwt
  end

end