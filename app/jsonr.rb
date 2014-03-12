require 'bundler/setup'
require 'sinatra'
require 'sinatra/json'
require 'barista'

require './app/parser'
require './app/comparer'

register Barista::Integration::Sinatra

Barista.configure do |c|
  c.output_root = 'public/js'
end

set :public_folder, 'public'

get '/' do
  redirect 'index.html'
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
