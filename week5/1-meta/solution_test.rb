require 'minitest/autorun'

require_relative 'solution'

class SolutionTest < Minitest::Test
  def test_to_proc
    assert_equal [3,4], [1,2].map(&'succ.succ')
  end
end
