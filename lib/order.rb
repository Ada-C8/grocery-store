#####################
# Planning
#The products should be added as a hash, where each hash is a key value pair with the name of the product as the key and the price of the product as the value.

#To add a new peroduct to the order you should allow the user to enter two arguments, one for the product name and one for the price of the item. Then in the add_product method you should format the user input into a hash that is added to the order.
#Maybe use the money gem to make sure all of our money is in the right format?

#To get the order total you should sum all the hash values and multiply it by the tax
#Should I have a list of object ID's and what they link to?



#Changed self.all method to create a hash for the product, so I think this broke some of my tests, because I wasn't treating @products as a hash in those tests
require 'csv'

module Grocery
  class Order
    attr_reader :id, :products
    #Need to allow 0 product to be entered
    def initialize(id, products)
      @id = id
      @products = products

    end #initialize

    def total
      sum = @products.values.inject(0) { |a, b| a + b }
      total = (sum + (sum * 0.075)).round(2)
      return total
    end #total

    def add_product(product_name, product_price)
      if @products.has_key?(product_name)
        return false
      else @products[product_name] = product_price
        return true
      end #if/else
    end #add_product

    def remove_product(product_name)
      if @products.key?(product_name) == false
        return false
      else
        @products.delete(product_name)
        return true
      end #if/else
    end #remove_product

    def self.all
      #method that will return an array of all the orders
      #the numnber of orders in the array is correct,
      all_orders = []
      CSV.open("support/orders.csv", 'r').each do |line|
        id = line[0]

        order_products = {}
        products = line[1].split(';')

        products.each do |item_price|
          product_price = item_price.split(':')
          order_products[product_price[0]] = product_price[1].to_f
        end

        products = order_products
        all_orders << Grocery::Order.new(id, products)
      end

      return all_orders
##### First try at self.all method (which didn't make hashes):
      # all_orders = []
      # product_hash = {}
      # CSV.open("support/orders.csv", 'r').each do |line|
      #   all_orders << Grocery::Order.new(line[0], line[1].split(";"))
      #   #do we need to loop though line[1] to get the items into a hash?
      #
      # end
      # return all_orders
    end #all

    def self.find(id)
      #self.find(id) - returns an instance of Order where the value of the id field in the CSV matches the passed parameter.
    end #self.find(id)

  end #Order class
end # Grocery module

 # test = Grocery::Order.all[0].products
 #
 # puts test







# test_order = Grocery::Order.new(123, {"apple" =>  3, "pear" => 2})
# list_before = test_order.products
# puts list_before
# test_order.remove_product("apple")
# list_after = test_order.products
# puts list_after
