require "money"
Money.use_i18n = false

module Grocery
  class Order
    attr_reader :id, :products

    def initialize(id, products)
      @id = id
      @products = products
    end

    def total
      # TODO: implement total
      sum = products.values.inject(0, :+)
      total = sum + (sum * 0.075).round(2)
      return total
    end

    def add_product(product_name, product_price)
      # TODO: implement add_product
      @products[product_name] = product_price
      if @products.has_key?(product_name) && @products.has_value?(product_price)
        return true
      else
        return false
      end
    end
  end
end
