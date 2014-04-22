describe 'Parser' do
  context 'hashes' do
    it 'parses empty hashes' do
      expected = <<-eos
{
}
    eos
      expected = expected.split("\n")
      Parser.new({}).parse.should == expected
    end

    it 'parses hashes' do
      expected = <<-eos
{
\t"key1": "value 1",
\t"key2": "value 2"
}
      eos
      expected = expected.split("\n")
      Parser.new({ key1: 'value 1', key2: 'value 2' }).parse.should == expected
    end

    it 'parses nested hashes' do
      expected = <<-eos
{
\t"key1": {
\t\t"key2": "value 2"
\t}
}
      eos
      expected = expected.split("\n")
      Parser.new({ key1: { key2: 'value 2' } }).parse.should == expected
    end
  end

  context 'arrays' do
    it 'parses empty arrays' do
      expected = <<-eos
[
]
    eos
      expected = expected.split("\n")
      Parser.new([]).parse.should == expected
    end

    it 'parses arrays' do
      expected = <<-eos
[
\t"value 1",
\t"value 2"
]
      eos
      expected = expected.split("\n")
      Parser.new(['value 1', 'value 2']).parse.should == expected
    end

    it 'parses nested arrays' do
      expected = <<-eos
[
\t"value 1",
\t[
\t\t"value 2",
\t\t"value 3"
\t]
]
      eos
      expected = expected.split("\n")
      Parser.new(['value 1', ['value 2', 'value 3']]).parse.should == expected
    end
  end

  it 'parses numbers' do
    expected = <<-eos
[
\t1.234
]
      eos
    expected = expected.split("\n")
    Parser.new([1.234]).parse.should == expected
  end

  it 'parses booleans' do
    expected = <<-eos
[
\tfalse
]
      eos
    expected = expected.split("\n")
    Parser.new([false]).parse.should == expected
  end

  it 'parses null' do
    expected = <<-eos
[
\tnull
]
      eos
    expected = expected.split("\n")
    Parser.new([nil]).parse.should == expected
  end
end