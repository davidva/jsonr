require 'sinatra'
require 'sinatra/json'

set :public_folder, 'public'

require 'barista'

register Barista::Integration::Sinatra

Barista.verbose = false

Barista.configure do |c|
  c.output_root = 'public/js'
end
