class Comparer
  def initialize(old_input, new_input)
    @old_input = old_input
    @new_input = new_input
  end

  def compare
    return [[], []] if old_input.empty? && new_input.empty?

    if same_line?
      process_same_line
    elsif line_removed?
      process_removed_line
    else
      process_added_line
    end
  end

  private

  attr_reader :old_input, :new_input

  def first_old_line_without_ending_comma
    @first_old_line_without_ending_comma ||= remove_ending_comma old_input.first
  end

  def first_new_line_without_ending_comma
    @first_new_line_without_ending_comma ||= remove_ending_comma new_input.first
  end

  def remove_ending_comma(value)
    return value if value.nil? || value[-1] != ','
    value[0..-2]
  end

  def same_line?
    first_old_line_without_ending_comma == first_new_line_without_ending_comma
  end

  def process_same_line
    Comparer.new(old_input.drop(1), new_input.drop(1)).compare.tap do |output|
      output[0].unshift value: old_input.first, status: ''
      output[1].unshift value: new_input.first, status: ''
    end
  end

  def line_removed?
    first_new_line_without_ending_comma.nil? || old_input_without_commas.include?(first_new_line_without_ending_comma)
  end

  def old_input_without_commas
    @old_input_without_commas ||= old_input.map { |line| remove_ending_comma line }
  end

  def process_removed_line
    Comparer.new(old_input.drop(1), new_input).compare.tap do |output|
      output[0].unshift value: old_input.first, status: 'removed'
      output[1].unshift value: ' ', status: ''
    end
  end

  def process_added_line
    Comparer.new(old_input, new_input.drop(1)).compare.tap do |output|
      output[0].unshift value: ' ', status: ''
      output[1].unshift value: new_input.first, status: 'added'
    end
  end
end
