module Grocery
  TAX = 0.075
  class Order
    attr_reader :id, :products

    def initialize(id, products)
      @id = id
      @products = products
    end

    def total
      return (@products.values.inject(:+) * (1 + TAX)).round(2)
    end

    def add_product(product_name, product_price)
      # TODO: implement add_product
    end
  end
end
