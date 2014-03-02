require 'capybara/rspec'
require 'capybara-webkit'

Capybara.app = Sinatra::Application
Capybara.javascript_driver = :webkit

feature 'jsonr', js: true do
  scenario 'formatting json' do
    visit '/'
    fill_in 'source', with: '{"ola":"ke ase"}'
    click_button 'format'

    page.should_not have_content 'Processing...'

    all(:css, 'code').map(&:text).should == ['{','"ola": "ke ase"','}']
  end

  scenario 'comparing two jsons' do
    visit '/'
    click_link 'compare two'

    fill_in 'source1', with: '{"ola":"ke ase"}'
    fill_in 'source2', with: '{"ola":"ke asia"}'
    click_button 'compare'

    page.should have_content 'Compare!'

    all(:css, 'code').map(&:text).should == [
      '{',                '{',
      '',                 '+ "ola": "ke asia"',
      '- "ola": "ke ase"', '',
      '}',                '}']
  end
end