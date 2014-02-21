describe 'Parser' do
  it 'parses strings' do
    Parser.new.parse('{"ola":"ke ase"}').should == ['{', "\t\"ola\": \"ke ase\"",'}']
  end

  it 'parses empty hashes'

  it 'parses hashes' do
    Parser.new.parse('{"ola":{"ke":"ase"}}').should == ['{', "\t\"ola\": {","\t\t\"ke\": \"ase\"","\t}",'}']
  end

  it 'parses empty arrays' do
    Parser.new.parse('{"ola":[ ]}').should == ['{', "\t\"ola\": []",'}']
  end

  it 'parses arrays' do
    Parser.new.parse('{"ola":["ke","ase"]}').should == ['{', "\t\"ola\": [\"ke\", \"ase\"]",'}']
  end

  it 'parses numbers'

  it 'parses booleans'

  it 'parses nil'
end