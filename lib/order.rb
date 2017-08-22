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
    end
  end
end
