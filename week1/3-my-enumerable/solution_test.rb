require 'minitest/autorun'

require_relative 'solution'

class SolutionTest < Minitest::Test

  COLL =  Collection.new(*1..10)

  def test_map
    collection = Collection.new(*1..5)

    assert_equal [2, 3, 4, 5, 6], collection.map(&:succ)
  end

  def test_filter
    collection = Collection.new(*1..10)

    assert_equal [1, 3, 5, 7, 9], collection.filter(&:odd?)
  end

  def test_reject
    collection = Collection.new(*1..10)

    assert_equal [1, 3, 5, 7, 9], collection.reject(&:even?)
  end

  def test_reduce
    collection = Collection.new(*1..10)

    assert_equal 55, collection.reduce { |sum, n| sum + n }
  end

  def test_include?
    collection = Collection.new(*1..10)

    assert_equal true, collection.include?(5)
  end

  def test_count
    collection = Collection.new(*1..10)

    assert_equal 10, collection.count
    assert_equal 1, collection.count(1)
  end

  def test_size
    collection = Collection.new(*1..10)

    assert_equal 10, collection.size
  end

  def test_group_by
    collection = Collection.new 1,2
    expected = {0=>[2], 1=>[1]}
    assert_equal expected, collection.group_by { |n| n % 2 }
  end

  def test_min
    assert_equal 1, COLL.min
    assert_equal 'aa', %w(abv aa).min
  end

  def test_min_by
    assert_equal 'a',%w(a ab).min_by { |w| w.length }
  end

  def test_max
    assert_equal 10, COLL.max
    assert_equal 'abv', %w(abv aa).max
  end

  def test_max_by
    assert_equal 'ab',%w(a ab).max_by { |w| w.length }
  end

  def test_minmax
    assert_equal [1, 10], COLL.minmax
  end

  def test_minmax_by
    assert_equal %w(a abv), %w(a ab abv).minmax_by { |n| n.length }
  end

  def test_take
    assert_equal [], COLL.take(0)
    assert_equal [1,2], COLL.take(2)
    assert_equal (1..10).to_a, COLL.take(11)
  end

  def test_take_while
    assert_equal [1,2,3], COLL.take_while { |n| n < 4 }
    assert_equal [], COLL.take_while { |n| n > 1 }
  end

  def test_drop
    assert_equal [10], COLL.drop(9)
  end

  def test_drop_while
    assert_equal [10], COLL.drop_while { |n| n < 10 }
  end
end
