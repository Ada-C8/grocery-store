module Grocery
  class Order
    attr_reader :id, :products

    def initialize(id, products)
      @id = id.to_i
      @products = products
    end

    def total
      # TODO: implement total
      sum = products.values.inject(0, :+)
      return sum + (sum * 0.075).round(2)
    end

    def add_product(product_name, product_price)
      # TODO: implement add_product
      unless @products.has_key?(product_name) # as long as the collection of products doesn't already have the key of the new item, you can add it to the list
        @products[product_name] = product_price
        return true
      else
        return false # otherwise, it isn't unique, and something with that name is already on file.
      end
    end
  end
end
