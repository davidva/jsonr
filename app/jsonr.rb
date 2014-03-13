require 'rubygems'
require 'bundler/setup'

Dir['./app/jsonr/*.rb'].each  { |f| require f }

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
