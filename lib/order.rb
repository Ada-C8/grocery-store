require 'simplecov'
SimpleCov.start

module Grocery
  class Order
    attr_reader :id, :products

    def initialize(id, products)
      @id = id
      @products = products
    end

    # Method to total each order with taxes.
    def total
      expected_total = 0
      products.values.each do |price|
        expected_total = expected_total + price
      end
      expected_total = (expected_total * 1.075).round(2)
      return expected_total
    end

    def add_product(product_name, product_price)
      # TODO: implement add_product
    end
  end
end
