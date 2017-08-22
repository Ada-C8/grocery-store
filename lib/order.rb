# Create a class inside of a module
# Create methods inside the class to perform actions
# Learn how Ruby does error handling
# Verify code correctness by testing

# For Wave 1, all tests have been provided for you. For each piece of functionality that you build, you should run the tests from the command line using the rake command. To focus on only one test at a time, change all it methods to xit except for the one test you'd like to run. All tests provided should be passing at the end of your work on Wave 1.
#
# Requirements
#
# Create a Grocery module which will contain an Order class and any future grocery store logic.
#
# Create an Order class which should have the following functionality:

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

module Grocery
  class Order
    attr_reader :id, :products

    def initialize(id, products)
      @id = id
      @products = products
    end

    def total
      if @products.length == 0
        return 0
      else
        sum = @products.values.inject(0, :+)
        expected_total = sum + (sum * 0.075).round(2)
        return expected_total
      end
    end

    def add_product(product_name, product_price)
      # EVALUATE TO SEE IF PRODUCT NAME IS ALREADY IN THE LIST
      if @products.include?(product_name)
        return false # And do not add to the list and end method
      else
        @products[product_name] = product_price # Add to hash
        if @products.include?(product_name) # Tests if it was added and if it was new
          return true
        end
      end
    end # DEF

    def remove_product(product_name)
      @products.delete(product_name)
      if @products.include?(product_name)
        return false
      end
    end # DEF

  end # CLASS
end # MODULE
