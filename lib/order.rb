module Grocery
  class Order
    attr_reader :id, :products

    def initialize(id, products)
      @id = id
      @products = products
    end

    def total
      # TODO: implement total
      @total = @products.values.inject(0, :+)
      @total_plus_tax = @total + (@total * 0.075).round(2)
      return @total_plus_tax
    end

    def add_product(product_name, product_price)
      # TODO: implement add_product
      @product_name = product_name
      @product_price = product_price
      @products.each do |key, value|
        if @product_name == key
          return false
        end
      end

      @products[@product_name] = @product_price
      return true
    end
  end
end
