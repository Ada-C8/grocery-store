module Grocery
  class Order
    attr_reader :id, :products

    def initialize(id, products)
      @id = id
      @products = products
    end

    def total
      final_total =
      if @products.length == 0
        final_total = 0
      else
        order_total = 0
        @products.each do |name, cost|
          order_total += cost
        end
        final_total = order_total + (order_total * 0.075).round(2)
      end
      return final_total
    end

    def add_product(product_name, product_price)
      if @products.keys.include?(product_name)
        return false
      else
        @products.store(product_name, product_price)
        return true
      end
    end

  end
end
