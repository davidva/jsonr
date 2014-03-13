class Comparer
  def compare input1, input2, output = [[],[]]
    return output if input1.empty? && input2.empty?

    first1 = remove_ending_comma input1.first
    first2 = remove_ending_comma input2.first

    if first1 == first2
      output[0] << {value: input1.first, status: ''}
      output[1] << {value: input2.first, status: ''}

      compare input1[1..-1], input2[1..-1], output
    elsif first2.nil? || input1.map {|line| remove_ending_comma line }.include?(first2)
      output[0] << {value: input1.first, status: 'removed'}
      output[1] << {value: ' ', status: 'removed'}

      compare input1[1..-1], input2, output
    else
      output[0] << {value: ' ', status: 'added'}
      output[1] << {value: input2.first, status: 'added'}

      compare input1, input2[1..-1], output
    end
  end

  private

  def remove_ending_comma value
    return value if value.nil? || value[-1] != ','
    value[0..-2]
  end
end