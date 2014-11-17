require 'bigdecimal'
require 'bigdecimal/util'

class Inventory
  attr_accessor :products

  def initialize
    @products = {}
  end
 
  def register(product, price)
    raise 'Invalid parameters passed' if product.length > 40 ||
                                         @products[product]  ||
                                         !(0.01..999.99).include?(price.to_f)
    @products[product] = price
  end

  def new_cart
    Cart.new(self)
  end
end


class Cart
  def initialize(inventory)
    @inventory = inventory
    @products = Hash.new(0)
  end

  def add(product, quantity = 1)
    raise 'Invalid product passed' unless @inventory.products[product]
    raise 'Invalid quantity'           if quantity < 1

    @products[product] += quantity
  end

  def total
    @products.map { |product, quantity| @inventory.products[product].to_d * quantity }
             .reduce(:+)
  end

  def invoice
    invoice = ['+------------------------------------------------+----------+',
               '| Name                                       qty |    price |',
               '+------------------------------------------------+----------+']
    @products.each do |product, quantity|
      invoice += ["| #{product.ljust(40)} #{quantity.rjust(5)} |#{('%0.2f' % @inventory.products[product]).rjust(10)}|",
                  '+------------------------------------------------+----------+']
    end
    invoice += ["| #{'TOTAL'.ljust(41)} |#{('%0.2f' % total).rjust(10)}|",
                '+------------------------------------------------+----------+']
    invoice.join "\n"
  end
end