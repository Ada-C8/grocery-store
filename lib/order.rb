module Grocery
  class Order
    attr_reader :id, :products

    def initialize(id, products)
      @id = id
      @products = products
    end

    def total
      if @products.length == 0
        return 0
      else
        order_total = 0
        @products.each do |name, cost|
          order_total += cost
        end
        return (order_total + (order_total * 0.075).round(2))
      end
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
