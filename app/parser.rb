class Parser
  def parse input, indent = ''
    json = JSON.parse(input)

    format(json).flatten
  end

  private

  def format element, indent = ''
    if element.is_a? Hash
      format_hash(element, indent)
    elsif element.is_a? Array
      format_array(element, indent)
    elsif element.is_a? Numeric
      [element.to_s]
    else
      [quote(element)]
    end
  end

  def format_hash hash, indent
    lines = ['{']
    keys = hash.keys
    unless keys.empty?
      last_element_key = keys.pop
      nested_indent = "#{indent}\t"
      keys.each { |k| lines.push format_hash_element(k, hash[k], nested_indent) }
      lines.push format_hash_element(last_element_key, hash[last_element_key], nested_indent, true)
    end
    lines.push "#{indent}}"
    lines
  end

  def format_hash_element key, value, indent, last = false
    lines = format(value, indent)
    lines[0] = "#{format_key(key, indent)}#{lines[0]}"
    return lines if last
    lines[-1] = "#{lines[-1]},"
    lines
  end

  def format_key key, indent
    "#{indent}#{quote key}: "
  end

  def format_array array, indent
    lines = ['[']
    unless array.empty?
      last_value = array.pop
      nested_indent = "#{indent}\t"
      array.each { |v| lines.push format_array_element(v, nested_indent) }
      lines.push format_array_element(last_value, nested_indent, true)
    end
    lines.push "#{indent}]"
    lines
  end

  def format_array_element value, indent, last = false
    lines = format(value, indent)
    lines[0] = "#{indent}#{lines[0]}"
    return lines if last
    lines[-1] = "#{lines[-1]},"
    lines
  end

  def quote value
    "\"#{value}\""
  end



  # end

  # private

  # def format_field key, value, indent
  #   line = "#{indent}\t#{quote(key)}:"

  #   if value.is_a? Hash
  #     format_hash(line, value, indent)
  #   elsif value.is_a? Array
  #     format_array(line, value)
  #   else
  #     ["#{line} #{quote(value)}"]
  #   end
  # end

  # def format_hash line, value, indent
  #   nested_lines = parse(value, indent + "\t")
  #   nested_lines[0] = "#{line} #{nested_lines[0]}"
  #   nested_lines
  # end

  # def format_array line, value
  #   avalue = if value.empty?
  #     ''
  #   else
  #     value.drop(1).inject(quote(value[0])) do |memo, elem|
  #       "#{memo}, #{quote(elem)}"
  #     end
  #   end
  #   ["#{line} [#{avalue}]"]
  # end

  # def quote value
  #   "\"#{value}\""
  # end
end