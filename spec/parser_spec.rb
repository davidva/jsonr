describe 'Parser' do
  it 'parses strings' do
    Parser.new.parse('{"ola":"ke ase"}').should == ['{', "\t\"ola\": \"ke ase\"",'}']
  end

  it 'parses nested elements' do
    Parser.new.parse('{"ola":{"ke":"ase"}}').should == ['{', "\t\"ola\": {","\t\t\"ke\": \"ase\"","\t}",'}']
  end

  it 'parses arrays'

  it 'parses numbers'

  it 'parses booleans'
end