# Create a Grocery module which will contain an Order class and any future grocery store logic.
#
# Create an Order class which should have the following functionality:
#
# A new order should be created with:
# an ID, read-only
# a collection of products and their cost
# zero products is permitted
# you can assume that there is only one of each product
# A total method which will calculate the total cost of the order by:
# summing up the products
# adding a 7.5% tax
# ensure the result is rounded to two decimal places
# An add_product method which will take in two parameters, product name and price, and add the data to the product collection
# It should return true if the item was successfully added and false if it was not

#Optional
# Add a remove_product method to the Order class which will take in one parameter, a product name, and remove the product from the collection
# It should return true if the item was successfully remove and false if it was not
#

module Grocery
  class Order
    attr_reader :id, :products

    def initialize(id, products)
      #@products_array = [] #Not sure if this will work, might need to make instance @product_array
      @id = id
      @products = products
      #@products_array << products
    end

    def total
      # implement total
      sum = 0
      @products.each do |key, value|
        sum += value
      end
      sum_incl_tax = (sum + (sum * 0.075)).round(2)
      return sum_incl_tax
    end

    def add_product(product_name, product_price)
      # : implement add_product
      #CHeck if item is already there, and if so replace it
      #@products.has_key?(product_name)
      if @products.include?(product_name)
        return false
      else
        @products[product_name] = product_price
        return true
      end

      #Whether it was there or not determines what to return (new or not?)


      #@products[product_name] = product_price
      #I had help to get this and I do not understand how the program knows to add this to @products.
      #This is how most porgrams understand to add something to a hash, and works as long as it's a hash.

    end
  end
end

#chocolate = Grocery::Order.new(345,"chocolate",3.00)

new_order = Grocery::Order.new(919, "salad" => 2.99)
new_order.add_product("jicama", 2.19)

puts new_order.products.keys
puts new_order.total
