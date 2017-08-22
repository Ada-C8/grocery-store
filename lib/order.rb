
module Grocery
  class Order
    attr_reader :id, :products

    def initialize(id, products)
      @id = id
      @products = products
    end

    def total
      # TODO: implement total
      subtotal = @products.values.inject(0, :+)
      total = (subtotal * 1.075).round(2)
      return total
    end

    def add_product(product_name, product_price)
      # TODO: implement add_product
    end
  end
end
