module Grocery
  class Order
    attr_reader :id, :products

    def initialize(id, products)
      @id = id
      @products = products
    end

    def total
      @sum = @products.values.inject(0, :+)
      @total = @sum + (@sum * 0.075).round(2)
      return @total
    end

    def add_product(product_name, product_price)
      @product_name = product_name
      @product_price = product_price
      @products.each do |key, value|
        if @product_name == key
          #puts "You've already added that product."
          return false
        end
      end
      @products[@product_name] = @product_price
      return @products
    end
  end
end
