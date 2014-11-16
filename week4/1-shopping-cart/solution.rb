class Inventory
  def initialize
    @products = {}
  end
 
  def register(product, price)
    raise 'Invalid parameters passed' if product.length > 40 ||
                                         @products[product] ||
                                         !(0.01..999.99).include?(price.to_f)
    @products[product] = price
  end
end
