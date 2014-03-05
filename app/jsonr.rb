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
  json [
    [
      {status: '',        value: '{'},
      {status: 'added',   value: "\t"},
      {status: 'removed', value: "\t\"ola\": \"ke ase\""},
      {status: '',        value: '}'}
    ], [
      {status: '',        value: '{'},
      {status: 'added',   value: "\t\"ola\": \"ke asia\""},
      {status: 'removed', value: "\t"},
      {status: '',        value: '}'}
    ]
  ]
end

get '/js/application.js' do
  coffee :application
end
