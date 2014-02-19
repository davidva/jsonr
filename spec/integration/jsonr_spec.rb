require File.expand_path '../../spec_helper.rb', __FILE__

feature 'jsonr', js: true do
  scenario 'should allow accessing the home page' do
    visit '/'
    fill_in 'source', with: '{"ola":"ke ase"}'
    click_button 'format'

    all(:css, 'code').map(&:text).should == ['{','','"ola": "ke ase"','}']
  end
end