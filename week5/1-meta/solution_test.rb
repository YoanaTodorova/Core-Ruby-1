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

  def test_singleton_class
    klass = Class.new
    a = klass.new
    a.singleton_class
  end

  def test_proxy
    proxy = Proxy.new [1,2,3]
    assert_equal [2], proxy & [2]
  end

  def test_delegate
    struct = Struct.new(:first_name, :last_name)

    i = Class.new do
      delegate :fist_name, to: '@user'
      delegate :last_name, to: '@user'

      def initialize(user)
        @user = user
      end
    end

    user = struct.new 'Genadi', 'Samokovarov'
    invoice = i.new(user)

    assert_equal 'Genadi', user.first_name
    assert_equal 'Samokovarov', user.last_name
  end
end
