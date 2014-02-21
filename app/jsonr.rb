require 'rubygems'
require 'bundler/setup'
require 'sinatra'
require 'sinatra/json'
require 'coffee-script'

require './app/parser'

get '/' do
  send_file File.join(settings.public_folder, 'index.html')
end

post '/format' do
  json Parser.new.parse(request.body.read)
end

get '/js/application.js' do
  coffee :application
end
