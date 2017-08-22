module Grocery
  class Order
    attr_reader :id, :products

    def initialize(id, products)
      @id = id
      @products = products
    end

    def total
      # TO DO: implement total
      sum = products.values.inject(0, :+)
      total = sum + (sum * 0.075).round(2)
      return total
    end

    def add_product(product_name, product_price)
      # TO DO: implement add_product
      @products.merge({product_name => product_price})
    end
  end
end

#order = Grocery::Order.new(221, {"banana" => 1.99, "cracker" => 3.00 })
#puts order.add_product("sandwich", 4.25)
