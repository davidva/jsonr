describe Comparer do
  subject do
    Comparer.new(old_input, new_input).compare
  end

  let(:comparison_value) { subject.map { |a| a.map { |line| line[:value] } } }

  let(:comparison_status) { subject.map { |a| a.map { |line| line[:status] } } }

  context 'empty inputs' do
    let(:old_input) { [] }

    let(:new_input) { [] }

    specify do
      comparison_value.should == [ [], [] ]
    end

    specify do
      comparison_status.should == [ [], [] ]
    end
  end

  context 'first input longer' do
    let(:old_input) { ['a'] }

    let(:new_input) { [] }

    specify do
      comparison_value.should == [ ['a'], [' '] ]
    end

    specify do
      comparison_status.should == [ ['removed'], [''] ]
    end
  end

  context 'second input longer' do
    let(:old_input) { [] }

    let(:new_input) { ['b'] }

    specify do
      comparison_value.should == [ [' '], ['b'] ]
    end

    specify do
      comparison_status.should == [ [''], ['added'] ]
    end
  end

  context 'same size inputs' do
    let(:old_input) { ['a'] }

    let(:new_input) { ['b'] }

    specify do
      comparison_value.should == [ [' ', 'a'], ['b', ' '] ]
    end

    specify do
      comparison_status.should == [ ['', 'removed'], ['added', ''] ]
    end
  end

  context 'same size inputs with equal line after the changes' do
    let(:old_input) { ['a', 'c'] }

    let(:new_input) { ['b', 'c'] }

    specify do
      comparison_value.should == [ [' ', 'a', 'c'], ['b', ' ', 'c'] ]
    end

    specify do
      comparison_status.should == [ ['', 'removed', ''], ['added', '', ''] ]
    end
  end

  context 'ignores ending \',\'' do
    let(:old_input) { ['a,', 'b'] }

    let(:new_input) { ['b,', 'c'] }

    specify do
      comparison_value.should == [ ['a,', 'b', ' '], [' ', 'b,', 'c'] ]
    end

    specify do
      comparison_status.should == [ ['removed', '', ''], ['', '', 'added'] ]
    end
  end
end
