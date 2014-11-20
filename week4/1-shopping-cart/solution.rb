require 'bigdecimal'
require 'bigdecimal/util'

class Inventory
  def initialize
    @products = {}
    @promotions = {}
    @coupons = []
  end
 
  def register(product, price, **promotion)
    raise 'Invalid parameters passed' if product.length > 40 ||
                                         @products[product]  ||
                                         !(0.01..999.99).include?(price.to_f)
    @products[product] = price
    @promotions[product] = Promotion.new promotion, self
  end

  def new_cart
    Cart.new(self)
  end

  def [](product)
    @products[product]
  end

  def register_coupon(name, percent: nil, amount: nil)
    @coupons << Coupon.new(name, percent: percent, amount: amount)
  end
end

class Coupon
  def initialize(name, **condition)
    @name = name
    @amount = condition[:amount]
    @percent = condition[:percent]
  end

  def apply

  end
end

class Promotion
  def initialize(promotion, inventory)
    case promotion.keys[0]
      when :get_one_free then GetOneFree.new(promotion[:get_one_free])
      when :package      then Package.new(promotion[:package])
      when :threshold    then Threshold.new(promotion[:threshold])
    end
  end
end

class GetOneFree
  def initialize(every_nth)
    @every_nth = every_nth
  end

  def calculate

  end

  def to_s
    "(buy #{@every_nth - 1}, get 1 free)"
  end
end

class Package
  def initialize(**condition)
    @package_count = condition.keys[0]
    @percent = condition.values[0]
  end

  def total

  end

  def to_s
    "(get #{@percent} off for every #{@package_count})"
  end
end

class Threshold
  def initialize(**condition)
    @after_nth = condition.keys[0]
    @percent = condition.values[0]
  end

  def total
    # : {10 => 50}
  end

  def to_s
    "(#{@percent} off after every the #{@after_nth})"
  end
end

class Product
  def initialize(name, price)
    @name, @price = name, price
  end
end

class Cart
  def initialize(inventory)
    @inventory = inventory
    @products = Hash.new(0)
  end

  def add(product, quantity = 1)
    raise 'Invalid product passed' unless @inventory[product]
    raise 'Invalid quantity'           if quantity < 1

    @products[product] += quantity
  end

  def total
    @products.map do |product, quantity|
      @inventory[product].to_d * quantity
    end.reduce(:+)
  end

  def invoice
    invoice = ['+------------------------------------------------+----------+',
               '| Name                                       qty |    price |',
               '+------------------------------------------------+----------+']
    invoice += @products.map do |product, quantity|
      price = ('%0.2f' % @inventory[product]).rjust(10)
      ["| #{product.ljust(40)} #{quantity.to_s.rjust(5)} |#{price}|",
       '+------------------------------------------------+----------+']
    end
    invoice += ["| #{'TOTAL'.ljust(46)} |#{('%0.2f' % total).rjust(10)}|",
                '+------------------------------------------------+----------+']
    invoice.join "\n"
  end

  def use(coupon_name)
    @coupon = coupon_name
  end
end