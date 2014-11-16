require 'minitest/autorun'

require_relative 'solution'

class SolutionTest < Minitest::Test
  def test_register
    inventory = Inventory.new
    inventory.register 'Green Tea', '1.99'
 
    assert_raises(RuntimeError) { inventory.register 'poveche ot chetiredeset simvola nadqvam se', '1.00' }
    assert_raises(RuntimeError) { inventory.register 'Green Tea', '1.00' }
    assert_raises(RuntimeError) { inventory.register 'Green Teaa', '0.001' }
  end
end
