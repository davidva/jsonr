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
    line = "#{indent}\t\"#{key}\":"

    if value.is_a? Hash
      nested_lines = parse(value, indent + "\t")
      nested_lines[0] = "#{line} #{nested_lines[0]}"
      nested_lines
    else
      ["#{line} \"#{value}\""]
    end
  end
end
