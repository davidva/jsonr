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
      [format_element(hash[key], true) { format_key(key) }]
    else
      key = hash.keys.first
      format_hash(hash.reject { |k,_| k == key }).unshift format_element(hash[key]) { format_key(key) }
    end
  end

  def format_element(value, last = false)
    lines = Parser.new(value, next_indent).parse
    lines[0] = "#{yield}#{lines[0]}"
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
      [format_element(array.first, true) { next_indent }]
    else
      format_array(array.drop(1)).unshift format_element(array.first) { next_indent }
    end
  end

  def quote value
    "\"#{value}\""
  end

  def next_indent
    @next_indent ||= "#{indent}\t"
  end
end
