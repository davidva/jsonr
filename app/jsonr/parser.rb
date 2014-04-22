class Parser
  def initialize(json, indent = '')
    @json = json
    @indent = indent
  end

  def parse
    case json
    when Hash
      ['{'].concat(format_hash(json)).push("#{indent}}")
    when Array
      ['['].concat(format_array(json)).push("#{indent}]")
    when Numeric, TrueClass, FalseClass
      [json.to_s]
    when NilClass
      ['null']
    else
      [quote(json)]
    end.flatten
  end

  private

  attr_reader :json, :indent

  def format_hash(hash)
    if hash.length == 0
      []
    elsif hash.length == 1
      key = hash.keys.first
      [format_hash_element(key, hash[key], true)]
    else
      key = hash.keys.first
      format_hash(hash.reject { |k,_| k == key }).unshift format_hash_element(key, hash[key])
    end
  end

  def format_hash_element(key, value, last = false)
    lines = Parser.new(value, next_indent).parse
    lines[0] = "#{format_key(key)}#{lines[0]}"
    return lines if last
    lines[-1] = "#{lines[-1]},"
    lines
  end

  def format_key(key)
    "#{next_indent}#{quote key}: "
  end

  def format_array(array)
    if array.length == 0
      []
    elsif array.length == 1
      [format_array_element(array.first, true)]
    else
      format_array(array.drop(1)).unshift format_array_element(array.first)
    end
  end

  def format_array_element(value, last = false)
    lines = Parser.new(value, next_indent).parse
    lines[0] = "#{indent}\t#{lines[0]}"
    return lines if last
    lines[-1] = "#{lines[-1]},"
    lines
  end

  def quote value
    "\"#{value}\""
  end

  def next_indent
    @next_indent ||= "#{indent}\t"
  end
end
