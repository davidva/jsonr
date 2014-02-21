class Parser
  def parse json, indent = ''
    hash = json.is_a?(Hash) ? json : JSON.parse(json)

    hash.inject ['{'] do |memo,(k,v)|
      memo.push format_field k, v, indent
      memo
    end.push("#{indent}}").flatten
  end

  private

  def format_field key, value, indent
    line = "#{indent}\t#{quote(key)}:"

    if value.is_a? Hash
      format_hash(line, value, indent)
    elsif value.is_a? Array
      format_array(line, value)
    else
      ["#{line} #{quote(value)}"]
    end
  end

  def format_hash line, value, indent
    nested_lines = parse(value, indent + "\t")
    nested_lines[0] = "#{line} #{nested_lines[0]}"
    nested_lines
  end

  def format_array line, value
    avalue = if value.empty?
      ''
    else
      value.drop(1).inject(quote(value[0])) do |memo, elem|
        "#{memo}, #{quote(elem)}"
      end
    end
    ["#{line} [#{avalue}]"]
  end

  def quote value
    "\"#{value}\""
  end
end
