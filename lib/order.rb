module Grocery
  class Order
    attr_reader :id, :products

    def initialize(id, products)
      @id = id
      @products = products
    end

    def total
      total = 0
      products.each do |name, price|
        total += price + (price * 0.075)
      end
      return total.round(2)
    end

    def add_product(product_name, product_price)
      if @products.key?(product_name)
        return false
      else
        @products[product_name] = product_price
        return true
      end
    end

    def remove_product(product_name)
      if @products.key?(product_name)
        @products.delete(product_name)
        return true
      else
        return false
      end
    end

  end #end  class Order
end #end module Grocery
#
#
# inventory = {
#   "apple" => 1.0,
#   "tomato_soup" => 2.0,
#   "milk" => 2.50,
#   "chicken" => 5.75
# }
#
# t = Grocery::Order.new(1, inventory)
# puts t.remove_product("apple")
