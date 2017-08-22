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
      if @products.keys.include?(product_name)
        return false
      else @products[product_name] = product_price
        return true
      end
    end
  end # of class
end # end of module


#order = Grocery::Order.new(221, {"banana" => 1.99, "cracker" => 3.00 })
#puts order.add_product("sandwich", 4.25)
#puts Grocery::Order[@products]["banana"]
