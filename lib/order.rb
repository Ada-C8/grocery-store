module Grocery
  class Order
    attr_reader :id, :products

    def initialize(id, products)
      # products if a hash with product name as key, price as value
      @id = id
      @products = products
    end

    def total
      # TODO: implement total
      total = 0

      # iterate through products hash and add to total
      products.each do |product_name, product_price|
        total += product_price
      end

      # add 7.5% tax and round to 2 decimal places
      return (total * 1.075).round(2)
    end

    def add_product(product_name, product_price)
      # TODO: implement add_product
    end
  end
end
