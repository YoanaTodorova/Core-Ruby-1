require 'minitest/autorun'

require_relative 'solution'

class SolutionTest < Minitest::Unit::TestCase
  def test_the_truth
    assert_equal true, true
  end
end
require 'minitest/autorun'

require_relative 'solution'

class SolutionTest < Minitest::Test
  def test_histogram
    assert_equal({ 'a' => 3, 'b' => 1, 'v' => 1 }, histogram('aaabv'))
  end

  def test_prime
    assert_equal(false, prime?(8))
    assert_equal(true, prime?(7))
  end

  def test_ordinal
    assert_equal('112th', ordinal(112))
  end

  def test_palindrom
    assert_equal(true, palindrome?(12_321))
    assert_equal(true, palindrome?('Race car'))
  end

  def test_anagram
    assert anagram?('silent', 'listen') == true
  end

  def test_anagram_case
    assert_equal(true, anagram?('Ms Mojo Risin', 'Jim Morisson'))
  end

  def test_remove_prefix
    assert_equal('Night Out', remove_prefix('Ladies Night Out', 'Ladies'))
  end

  def test_remove_suffix
    assert_equal('Ladies', remove_suffix('Ladies Night Out', ' Night Out'))
  end

  def test_digits
    assert_equal([1, 2, 3, 4, 5], digits(12_345))
  end

  def test_fizzbuzz
    assert_equal([1, 2, :fizz, 4, :buzz, :fizz, 7], fizzbuzz(1..7))
  end

  def test_count
    assert_equal({ 'words' => 2, 'this' => 1, 'is' => 1, 'array' => 1, 'of' => 1 },
                 count(%w(this is array of words words)))
  end

  def test_count_words
    assert_equal({ 'this' => 2, 'is' => 2, 'a' => 1, 'bro' => 2, 'it' => 1, 'sentence' => 1 },
                 count_words('This is a sentence, bro.', 'Bro, this is it.'))
  end
end