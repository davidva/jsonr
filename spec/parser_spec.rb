describe 'Parser' do
  it 'parses empty JSON' do
    Parser.new('{"ola":"ke ase"}').parse.should == ['{', "\t\"ola\": \"ke ase\"",'}']
  end
end