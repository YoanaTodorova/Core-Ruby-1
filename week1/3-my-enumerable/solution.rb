module MyEnumerable
  def map
    result = []
    each { |el| result << yield(el) }
    result
  end

  def filter
    result = []
    each { |el| result << el if yield el }
    result
  end

  def reject
    result = []
    each { |el| result << el if !yield el }
    result
  end

  def reduce(initial = nil)
    result = initial || self[0]
    each { |el| result = yield result, el }
    result
  end

  def any?
    each { |el| return true if yield el }
    false
  end

  def all?
    each { |el| return false if !yield el }
    true
  end

  def compact
    result = []
    each { |el| result << el if !!el }
    self.class.new *result
  end

  def each_cons(n)
    result = []
    (0..length-n).each do |index|
      result << self[index,n]
    end
    result
  end

  def include?(element)
    each { |el| return true if el == element }
    false
  end

  def count(element = nil)
    return size unless element
    result = 0
    each { |el| result += 1 if el == element }
    result
  end

  def size
    result = 0
    each { |_| result += 1 }
    result
  end

  def group_by

  end

  def min
    # Your code goes here.
  end

  def min_by
    # Your code goes here.
  end

  def max
    # Your code goes here.
  end

  def max_by
    # Your code goes here.
  end

  def minmax
    # Your code goes here.
  end

  def minmax_by
    # Your code goes here.
  end

  def take(n)
    return each.to_a if n >= size
    result = []
    each do |el|
      return result if result.size == n
      result << el
    end
    result
  end

  def take_while
    result = []
    each do |el|
      return result unless yield el
      result << el
    end
    result
  end

  def drop(n)
    return [] if n >= size
    each.to_a.reverse.take(size - n).reverse
  end

  def drop_while
    count = 0
    each do |el|
      return drop(count) unless yield el
      count += 1
    end
    drop(count)
  end
end

class Co
  include MyEnumerable

  def initialize(*data)
    @data = data
  end

  def each
    return to_enum(:each) unless block_given?
    @data.each { |el| yield el }
  end
end