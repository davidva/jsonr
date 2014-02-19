require File.expand_path '../../spec_helper.rb', __FILE__

feature 'jsonr', js: true do
  scenario 'should allow accessing the home page' do
    visit '/'
    page.should have_content 'Ola ke ase!'
  end
end