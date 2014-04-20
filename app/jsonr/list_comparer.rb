class ListComparer
  def initialize(json)
    @json = json
  end

  def process
    @json.map { |e| Parser.new.parse(e) }.each_cons(2).map do |a|
      Comparer.new.compare(*a)
    end
  end
end