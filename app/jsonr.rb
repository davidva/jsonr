require 'rubygems'
require 'bundler/setup'

Dir['./app/jsonr/*.rb'].each  { |f| require f }

get '/' do
  redirect 'index.html'
end

post '/format' do
  output = Parser.new(json_body).parse
  json output
end

post '/compare_two' do
  input = json_body
  input1 = Parser.new(JSON.parse(input['source1'])).parse
  input2 = Parser.new(JSON.parse(input['source2'])).parse
  output = Comparer.new(input1, input2).compare
  json output
end

post '/compare_list' do
  output = ListComparer.new(json_body).process
  json output
end

private

def json_body
  JSON.parse(request.body.read)
end