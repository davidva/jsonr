require 'rubygems'
require 'bundler/setup'
require 'sinatra'
require 'coffee-script'

get '/' do
  send_file File.join(settings.public_folder, 'index.html')
end

get '/application.js' do
  coffee :application
end
