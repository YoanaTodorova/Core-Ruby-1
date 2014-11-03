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
    result = initial
    index = 0
    each do |el|
      if index == 0
        result ||= el
        index = 1
      else
        result = yield result, el
      end
    end
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
    Hash.new([]).tap do |hash|
      each { |el| hash[yield el] << el }
    end
  end

  def min
    index = 0
    min = nil
    each do |el|
      if index == 0
        min = el
        index = 1
      else
        min = el if el < min
      end
    end
    min
  end

  def min_by
    index = 0
    min = nil
    each do |el|
      if index == 0
        min = el
        index = 1
      else
        min = el if yield(el) < yield(min)
      end
    end
    min
  end

  def max
    index = 0
    max = nil
    each do |el|
      if index == 0
        max = el
        index = 1
      else
        max = el if el > max
      end
    end
    max
  end

  def max_by
    index = 0
    max = nil
    each do |el|
      if index == 0
        max = el
        index = 1
      else
        max = el if yield(el) > yield(max)
      end
    end
    max
  end

  def minmax
    [min, max]
  end

  def minmax_by(&block)
    [min_by(&block), max_by(&block)]
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

class Collection
  include MyEnumerable

  def initialize(*data)
    @data = data
  end

  def each
    return to_enum(:each) unless block_given?
    @data.each { |el| yield el }
  end
end