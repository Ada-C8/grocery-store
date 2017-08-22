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
      # TODO: implement add_product
    end
  end
end
