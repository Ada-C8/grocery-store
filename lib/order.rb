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

    # Method to add products.
    def add_product(product_name, product_price)
      if @products.include?(product_name)
        return false
      else !@products.include?(product_name)
        @products[product_name] = product_price
        return true
      end
    end
  end
end
