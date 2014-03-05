describe Comparer do
  context 'first input longer' do
    let(:output) do
      Comparer.new.compare ['a'], []
    end

    specify do
      output[0].map { |line| line[:value] }.should == ['a']
      output[1].map { |line| line[:value] }.should == [' ']
    end

    specify do
      output[0].map { |line| line[:status] }.should == ['removed']
      output[1].map { |line| line[:status] }.should == ['removed']
    end
  end

  context 'second input longer' do
    let(:output) do
      Comparer.new.compare [], ['b']
    end

    specify do
      output[0].map { |line| line[:value] }.should == [' ']
      output[1].map { |line| line[:value] }.should == ['b']
    end

    specify do
      output[0].map { |line| line[:status] }.should == ['added']
      output[1].map { |line| line[:status] }.should == ['added']
    end
  end

  context 'same size inputs' do
    let(:output) do
      Comparer.new.compare ['a'], ['b']
    end

    specify do
      output[0].map { |line| line[:value] }.should == [' ','a']
      output[1].map { |line| line[:value] }.should == ['b',' ']
    end

    specify do
      output[0].map { |line| line[:status] }.should == ['added','removed']
      output[1].map { |line| line[:status] }.should == ['added','removed']
    end
  end

  context 'same size inputs with equal line after the changes' do
    let(:output) do
      Comparer.new.compare ['a','c'], ['b','c']
    end

    specify do
      output[0].map { |line| line[:value] }.should == [' ','a','c']
      output[1].map { |line| line[:value] }.should == ['b',' ','c']
    end

    specify do
      output[0].map { |line| line[:status] }.should == ['added','removed','']
      output[1].map { |line| line[:status] }.should == ['added','removed','']
    end
  end

  context 'ignores ending \',\'' do
    let(:output) do
      Comparer.new.compare ['a,','b'], ['b,','c']
    end

    specify do
      output[0].map { |line| line[:value] }.should == ['a,','b',' ']
      output[1].map { |line| line[:value] }.should == [' ','b,','c']
    end

    specify do
      output[0].map { |line| line[:status] }.should == ['removed','','added']
      output[1].map { |line| line[:status] }.should == ['removed','','added']
    end
  end
end