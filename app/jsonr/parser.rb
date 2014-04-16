class Parser
  def parse(json, indent = '')
    format(json).flatten
  end

  private

  def format(element, indent = '')
    case element
    when Hash
      format_hash(element, indent)
    when Array
      format_array(element, indent)
    when Numeric, TrueClass, FalseClass
      [element.to_s]
    when NilClass
      ['null']
    else
      [quote(element)]
    end
  end

  def format_hash(hash, indent)
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

  def format_hash_element(key, value, indent, last = false)
    lines = format(value, indent)
    lines[0] = "#{format_key(key, indent)}#{lines[0]}"
    return lines if last
    lines[-1] = "#{lines[-1]},"
    lines
  end

  def format_key(key, indent)
    "#{indent}#{quote key}: "
  end

  def format_array(array, indent)
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

  def format_array_element(value, indent, last = false)
    lines = format(value, indent)
    lines[0] = "#{indent}#{lines[0]}"
    return lines if last
    lines[-1] = "#{lines[-1]},"
    lines
  end

  def quote(value)
    "\"#{value}\""
  end
end
