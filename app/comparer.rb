class Comparer
  def compare input1, input2, output = [[],[]]
    if input2.first
      if input1.first == input2.first
        output[0] << {value: input1.first, status: ''}
        output[1] << {value: input2.first, status: ''}
        compare input1[1..-1], input2[1..-1], output
      else
        output[0] << {value: '', status: 'added'}
        output[1] << {value: input2.first, status: 'added'}
        compare input1, input2[1..-1], output
      end
    elsif input1.first
      output[0] << {value: input1.first, status: 'removed'}
      output[1] << {value: '', status: 'removed'}
      compare input1[1..-1], input2, output
    else
      output
    end
  end
end