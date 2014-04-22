class ListComparer
  def initialize(json)
    @json = json
  end

  def process
    @json.map { |e| Parser.new(e).parse }.each_cons(2).map do |a|
      Comparer.new(*a).compare
    end
  end
end