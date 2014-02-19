require 'rubygems'
require 'bundler/setup'
require 'sinatra'
require 'sinatra/json'
require 'coffee-script'

get '/' do
  send_file File.join(settings.public_folder, 'index.html')
end

post '/format' do
  json ['{','',"\t\"ola\": \"ke ase\"",'}']
end

get '/js/application.js' do
  coffee :application
end
