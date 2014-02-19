require 'rspec'
require 'capybara/dsl'
require 'capybara/rspec'
require 'capybara-webkit'

require File.expand_path '../../app/jsonr.rb', __FILE__

Sinatra::Application.environment = :test

Capybara.app = Sinatra::Application
Capybara.javascript_driver = :webkit

RSpec.configure do |config|
  config.include Capybara
end