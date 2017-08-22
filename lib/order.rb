module Grocery
  class Order
    attr_reader :id, :products

    def initialize(id, products)
      # products if a hash with product name as key, price as value
      @id = id
      @products = products
    end

    def total
      # implement total
      total = 0

      # iterate through products hash and add to total
      products.each_value do |product_price|
        total += product_price
      end

      # add 7.5% tax and round to 2 decimal places
      return (total * 1.075).round(2)
    end

    def add_product(product_name, product_price)
      # implement add_product

      # don't add product if already in @products
      if @products.include?(product_name)
        return false
      # else add to hash
      else
        @products[product_name] = product_price
        return true
      end
    end

    def remove_product(product_name)
      if @products.include?(product_name)
        @products.delete(product_name)
        return true
      else
        return false
      end
    end

  end
end
