require 'minitest/autorun'

require_relative 'solution'

class SolutionTest < Minitest::Test
  def test_to_proc
    assert_equal [3,4], [1,2].map(&'succ.succ')
  end

  def test_nil
    assert_equal nil, nil.foo
  end

  def test_singleton_method
    klass = Class.new
    a = klass.new
    a.define_singleton_method(:m) { puts 42 }

    assert_raises(NoMethodError) { klass.m }
  end
end
