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
      unless @products.has_key?(product_name)
        @products[product_name] = product_price
        return true
      else
        return false
      end
    end

    def remove_product(product_name)
      if @products.has_key?(product_name)
        @products.delete(product_name)
      else
        return @products
      end


    end

  end
end
