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

require 'CSV'

module Grocery
  class Order
    attr_reader :id, :products

    def initialize(id, products)
      #@products_array = [] #Not sure if this will work, might need to make instance @product_array
      @id = id
      @products = products
      #@products_array << products
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

    def self.all

      orders = []
      CSV.open("../support/orders.csv", 'r').each do |line|
        id = line[0].to_i
        products_hash = {}
        products_arr = line[1].split';'
        products_arr.each do |item_and_price|
          product_price = item_and_price.split':'
          products_hash[product_price[0]] = product_price[1].to_f
        end
        orders << self.new(id, products_hash)
      end
      return orders
    end

    def self.find(id)
      orders = Order.all
      # found = nil
      # if orders([0]..orders.length).include?(id)
      #   order = found
      #   puts found
      # else
      #   puts "Garbage"
      #if Order.all.id.include?(id)
      #
      # orders_array = [Grocery::Order.all]
      #orders.length.times do
      # found = nil
      unless orders(0..orders.length).include?(id)
        raise ArgumentError.new("Invalid order #{id}")
      end
      found = nil
      orders.each do |individual_order|
        if orders.id == individual_order
          found = individual_order
        end
      end
      return found
    end


    # Grocery::Order.all.each do |order|
    #   if Order.@id == id
    #end == val
    #if orders_array[0] == val
    #   return "true"
    # else
    #   return "false"
  end
end

# CSV.open('../support/orders.csv', 'r').each do |line|
#   id = line[0].to_i
#   products_arr = line[1].split(';')
#   products = Hash[products_arr.map { |i| i.split(":") }]
#   products = Hash[products.keys.zip(products.values.map(&:to_f))]
#
#   order = Grocery::Order.new(id, products)
#   all_orders << order
# end
# return all_orders







#Whether it was there or not determines what to return (new or not?)


#@products[product_name] = product_price
#I had help to get this and I do not understand how the program knows to add this to @products.
#This is how most porgrams understand to add something to a hash, and works as long as it's a hash.


#chocolate = Grocery::Order.new(345,"chocolate",3.00)

# new_order = Grocery::Order.new(919, "salad" => 2.99)
# new_order.add_product("jicama", 2.19)
#
# puts new_order.products.keys
# puts new_order.total

# Grocery::Order.each do
#   puts id
# end

#print Grocery::Order.all[0].id

o = Grocery::Order.all

print o[1].id

print o
#puts o.find(230)
