# explore-webrtc-go-ruby

Create a free 1:1 video chat application with Ruby, Sinatra, and Twilio WebRTC Go.

## Setup

- Create [a Twilio account](https://www.twilio.com/referral/D4tqHM) if you don't have one yet. It's free!
- Clone this repository.
- Generate a new API Key from the [Twilio Console](https://www.twilio.com/console/project/api-keys).
- Create a _.env_ file by copying the _.env.template_ file. Replace the placeholder text with the values for your Twilio Account SID, API Key SID, and API Key Secret.
- Install dependencies by running `bundle install` from the root of the project.
-  Run the server on port 5000 with the command `bundle exec rackup -p 5000`.
- Make sure you have [ngrok](https://ngrok.com/) installed on your machine.
- Run ngrok on port 5000 with the command `ngrok http 5000`.
- Once ngrok is running, open one of the URLs next to `Forwarding` in your browser:

```
ngrok by @inconshreveable                                       (Ctrl+C to quit)

Session Status                online
Account                      <YOUR_ACCOUNT_NAME>
Version                       2.3.40
Region                        <YOUR_REGION>
Web Interface                 http://127.0.0.1:4040
Forwarding                    <URL> -> http://localhost:5000
Forwarding                    <URL> -> http://localhost:5000
```
