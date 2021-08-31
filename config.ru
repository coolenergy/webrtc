require 'dotenv'
Dotenv.load

require './server'
configure { set :server, :puma }
run VideoApp
