module Grocery
  class Order
    attr_reader :id, :products

    def initialize(id, products)
      @id = id
      @products = {}

      if products.length > 0
        products.each {|product, value| @products[product] = value}
      end

    end

    def total
      sum = 0
      products.each_value do |value|
        sum = sum + value
      end
      expected_total = sum + (sum * 0.075).round(2)
      return expected_total
    end

    def add_product(product_name, product_price)
      @products[product_name] = product_price
    end
  end
end
