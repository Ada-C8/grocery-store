#
# Create a Grocery module which will contain an Order class and any future grocery store logic.
#
# Create an Order class which should have the following functionality:
#
# A new order should be created with:
#   an ID, read-only
#   a collection of products and their cost
#   zero products is permitted
#   you can assume that there is only one of each product
# A total method which will calculate the total cost of the order by:
#   summing up the products
#   adding a 7.5% tax
#   ensure the result is rounded to two decimal places
# An add_product method which will take in two parameters, product name and price, and add the data to the product collection
#   It should return true if the item was successfully added and false if it was not

module Grocery
  class Order
    attr_reader :id, :products

    def initialize(id, products)
      @id = id
      @products = products
    end

    def total
      # @products = { "banana" => 1.99, "cracker" => 3.00 }
      product_total = 0
      @products.each do |product_name, product_price|
        product_total += product_price
      end
      return grand_total = product_total + (product_total * 0.075).round(2)
    end

    def add_product(product_name, product_price)
      if @products.key?(product_name)
        return false
      else
        @products[product_name] = product_price
        return true
      end
    end

    def remove_product(product_name)
      if @products.key?(product_name)
        @products.delete(product_name)
        return true
      else
        return false
      end
    end
  end
end
