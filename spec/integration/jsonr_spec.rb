feature 'jsonr', js: true do
  scenario 'should allow accessing the home page' do
    visit '/'
    fill_in 'source', with: '{"ola":"ke ase"}'
    click_button 'format'

    page.should have_content 'Format!'

    all(:css, 'code').map(&:text).should == ['{','"ola": "ke ase"','}']
  end
end