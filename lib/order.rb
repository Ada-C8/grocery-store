require 'pry'
require 'csv'
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

# Requirements
#
# Update the Order class to be able to handle all of the fields from the CSV file used as input
  # To try it out, manually choose the data from the first line of the CSV file and ensure you can create a new instance of your Order using that data
# Add the following class methods to your existing Order class
  # self.all - returns a collection of Order instances, representing all of the Orders described in the CSV. See below for the CSV file specifications
    # Determine if the data structure you used in Wave 1 will still work for these new requirements
    # Note that to parse the product string from the CSV file you will need to use the split method
  # self.find(id) - returns an instance of Order where the value of the id field in the CSV matches the passed parameter.

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

    # def from_csv
    #   CSV.read("../support/orders.csv", 'r')
    # end

    def self.all
      order = []
      CSV.open("support/orders.csv", 'r').each do |line|
        # the below line accesses the ID number and then hold it for now.
        id = line[0].to_i
        # the below line accesses the products hash in csv and then hold it for now.
        products = line[1]

        # .split method splits csv row elements by the semi-colon returns an array of product:price
        split_products = products.split(";")

        # Now we are spliting each product:price into a hash of product and price.

        # this stores completed key/value pair.
        products_hash = {}
        # .each ensres the product:price split happens for each row.
        split_products.each do |product_colon_price| # product_colon_price represents the content of the array.
          # we are storing the split element in colon_split
          colon_split = product_colon_price.split(":")
          products_hash[colon_split[0]] = colon_split[1].to_f
        end
        # Adding in each new instance to the order array.
        order << self.new(id, products_hash)
      # hash = Hash[*csv.split(',')]
      end
      # csv.each do |row|
      #   list.split(",").select{|elem| elem != "b"}.join(",")
      return order
    end

    def self.find(id)
      # Sarah Read-?
      # counter = 0
      self.all.each do |order_object|
        if id == order_object.id
          return order_object
        end
      end
      raise ArgumentError.new("Invalid order number - order does not exist")
      # Sarah Read-? code
      # if counter == 0
      #   raise ArgumentError.new("Invalid order number - order does not exist")
      # end
      # return "please enter a valid order id"
    end

  end
end
# Here we are testing the return of the code in lines 73, 75, and 83
# Grocery::Order.all.each do |orders|
#   puts "testing"
#   puts orders.products
#   puts "testing"
# end

# # puts Grocery::Order.all.id
# # print Grocery::Order.all[0].products
#
# # binding.pry
#
#
#
# puts
