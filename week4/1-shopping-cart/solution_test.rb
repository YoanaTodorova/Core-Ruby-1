require 'minitest/autorun'
require 'bigdecimal'
require 'bigdecimal/util'

require_relative 'solution'

class SolutionTest < Minitest::Test
  def test_register
    inventory = Inventory.new
    inventory.register 'Green Tea', '1.99'
 
    assert_raises(RuntimeError) { inventory.register 'poveche ot chetiredeset simvola nadqvam se', '1.00' }
    assert_raises(RuntimeError) { inventory.register 'Green Tea', '1.00' }
    assert_raises(RuntimeError) { inventory.register 'Green Teaa', '0.001' }
  end

  def test_total
    inventory = Inventory.new
    inventory.register 'Green Tea', '1.99'
    inventory.register 'Red Tea',   '2.49'
    inventory.register 'Earl Grey', '1.49'

    cart = inventory.new_cart

    cart.add 'Green Tea'
    cart.add 'Red Tea', 2
    cart.add 'Green Tea', 2

    cart.total # връща '10.95'.to_d 
    assert_equal '10.95'.to_d, cart.total
  end

  def test_invoice
    inventory = Inventory.new
    inventory.register 'Green Tea', '1.99'
    inventory.register 'Red Tea',   '2.49'
    inventory.register 'Earl Grey', '1.49'

    cart = inventory.new_cart

    cart.add 'Green Tea'
    cart.add 'Red Tea', 2
    cart.add 'Green Tea', 2

    puts "invoiceeeeeeee"
    puts cart.invoice
  end
end

