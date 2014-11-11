require 'minitest/autorun'

require_relative 'solution'

class SolutionTest < Minitest::Test
  def test_initialization
    board = GameOfLife::Board.new [0, 0], [1, 1], [2, 2]

    assert true
  end

  def test_count
    board = GameOfLife::Board.new [0, 0], [1, 1], [2, 2]

    assert_equal 3, board.count
  end

  def test_skobi
    board = GameOfLife::Board.new [0, 0], [1, 1], [2, 2]

    assert_equal true, board[0,0]
    assert_equal false, board[0,2]
  end

  def test_next_generation
    board = GameOfLife::Board.new [0, 0], [1, 1], [2, 2]
    next_gen = GameOfLife::Board.new([0, 1], [1, 1], [2, 1], [1, 2]).next_generation

    p "next_generation #{next_gen.inspect}"
    assert_equal GameOfLife::Board.new([1,1]), board.next_generation
    assert_equal true, next_gen[1,1]
  end
end

# с по-малко от два живи съседа, умира (underpopulation).
# с два или три живи съседа продължава да живее и в следващото поколение.
# с повече от три живи съседа, умира (overpopulation).
# мъртва с точно три живи съседа, се ражда (reproduction).