class Array
  def to_hash
    Hash[*(map { |e| e.empty? ? [[]] : e }.flatten(1))]
  end

  def index_by(&block)
    Hash[map(&block).zip(self)]
  end

  def occurences_count
    Hash.new(0).tap { |hsh| each { |el| hsh[el] += 1 } }
  end

  def subarray_count(subarray)
    each_cons(subarray.length).to_a.count(subarray)
  end
end