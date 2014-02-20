class Parser
  attr_reader :json

  def initialize json
    @json = JSON.parse json
  end

  def parse
    array = ['{']
    json.each do |k,v|
      array.push "\t\"#{k}\": \"#{v}\""
    end
    array.push '}'
    array
  end
end
