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
    end

    def add_product(product_name, product_price)
      # TODO: implement add_product
      @products[product_name] = product_price
      if @products.has_key(product_name) && @products.has_value(product_price)
        return true
      else
        return false
      end
    end
  end
end
