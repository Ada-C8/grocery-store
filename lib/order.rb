module Grocery
  class Order
    attr_reader :id, :products

    def initialize(id, products = 0)
      @id = id
      @products = products
    end

    def total
      sum = 0
      @products.values.each do |price|
        sum += price
      end
      sum = sum + (sum * 0.075).round(2)
    end

    def add_product(product_name, product_price)
      if @products.has_key?(product_name)
        return false
      else
        @products[product_name] = product_price
        return true
      end
    end
  end
end
