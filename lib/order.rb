module Grocery
  class Order
    attr_reader :id, :products

    def initialize(id, products)
      @id = id
      @products = products
    end

    def total
      sum = 0
      products.each do |product, price|
        sum += price
      end
      total = (sum + sum * 0.075).round(2)
      return total
    end

    def add_product(product_name, product_price)
      if @products.keys.include?(product_name)
        return false
      else
        @products[product_name] = product_price
        return true
      end
    end

    def remove_product(product_name)
      if @products.keys.include?(product_name)
        @products.delete(product_name)
        return true
      else
        return false
      end 
    end
  end
end

# order = Grocery::Order.new(2314, {"banana" => 1.99, "cracker" => 3.00})
#
# order.add_product("salad", 4.25)
# p order.products
