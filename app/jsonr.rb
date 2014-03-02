require 'rubygems'
require 'bundler/setup'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'sinatra/json'
require 'coffee-script'

require './app/parser'

get '/' do
  send_file File.join(settings.public_folder, 'index.html')
end

post '/format' do
  json Parser.new.parse(request.body.read)
end

post '/compare_two' do
  json [
    ['{', "\t",                     "\t\"ola\": \"ke ase\"", '}'],
    ['{', "\t\"ola\": \"ke asia\"", "\t",                    '}']
  ]
end

get '/js/application.js' do
  coffee :application
end
