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
    lines = ["#{indent}\t\"#{key}\":"]
    if value.is_a? Hash
      new_lines = parse(value, indent + "\t")
      new_lines[0] = "#{lines[0]} #{new_lines[0]}"
      new_lines
    elsif value.is_a? Array
      lines[0] += value.to_s
    else
      lines[0] += " \"#{value}\""
    end
  end
end
