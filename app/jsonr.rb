require 'rubygems'
require 'bundler/setup'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'sinatra/json'
require 'coffee-script'

require './app/parser'
require './app/comparer'

get '/' do
  send_file File.join(settings.public_folder, 'index.html')
end

post '/format' do
  json Parser.new.parse(JSON.parse(request.body.read))
end

post '/compare_two' do
  input = JSON.parse(request.body.read)
  input1 = Parser.new.parse JSON.parse(input['source1'])
  input2 = Parser.new.parse JSON.parse(input['source2'])
  output = Comparer.new.compare input1, input2
  json output
end

get '/js/application.js' do
  coffee :application
end
