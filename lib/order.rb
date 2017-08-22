module Grocery
  class Order
    attr_reader :id
    attr_accessor :products

    def initialize(id, products)
      @id = id
      @products = products
      @tax = 0.075
    end

    def total
      # TODO: implement total
      sum = @products.values.inject(0, :+)
      return sum + (sum * @tax).round(2)
    end

    def add_product(product_name, product_price)
      # TODO: implement add_product
      if @products.has_key?(product_name)
        return false
      else
        @products[product_name] = product_price
        return true
      end
    end
  end
end
