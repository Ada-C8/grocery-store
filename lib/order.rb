
# Add the following class methods to your existing Order class

# Determine if the data structure you used in Wave 1 will still work for these new requirements
# Note that to parse the product string from the CSV file you will need to use the split method
# self.find(id) - returns an instance of Order where the value of the id field in the CSV matches the passed parameter.
require 'csv'
# self.all - returns a collection of Order instances, representing all of the Orders described in the CSV. See below for the CSV file specifications
module Grocery
  class Order
    @@all_orders = 42

    attr_reader :id, :products

    def initialize(id, products)#products is a hash with item => price
      @id = id.to_i
      @products = products
      @total = 0
    end #initialize

    def self.all
      return @@all_orders
    end #self.all method

    def total
      pretax = 0
      @products.each_value do |value|
        pretax += value
      end #each item calculation
      @total = pretax + (0.075 * pretax).round(2)
      return  @total
    end #total method

    def add_product(product_name, product_price)
      if @products.keys.include?(product_name)
        return false
      else
        @products[product_name] = product_price
        return true #@products
      end
    end #add_product method

    def remove_product(product_name)
      if @products.keys.include?(product_name)
        @products.delete(product_name)
        return true
      end #if include
    end #remove_product method

    def show_order
      list = ""
      @products.each do |product_name, product_price|
        list += "#{product_name}:\t #{product_price}\n"
      end #each end
      return list
    end #show order method end

  end #class end
end #module


#id = 1337
many_orders = []
products = {}

CSV.open('../support/orders.csv', 'r').each do |line|
  id = line[0].to_i
  x = line[1].split(';')
  #puts "x is #{x} and it is class #{x.class}"

  x.each do |item|
    y = item.split(":")
    #puts "y is #{y} and it is #{y.class}\n\n"
    x.length.times do
      products[y[0]] = y[1]
    end

    puts "products is now #{products}"
    puts "*****************"
  end #of x.each do
  puts "WHDHFSDFOIJWEOIFEWOIFNOIEWNFEOI"
    many_orders << Grocery::Order.new(id, products)
    products = {}
end #of CSV line by line
puts "____________________________________"

# 1, Slivered Almonds:22.88;   Wholewheat flour:1.93;   Grape Seed Oil:74.9
# 2, Albacore Tuna:36.92;Capers:97.99;Sultanas:2.82;Koshihikari rice:7.55
# 3, Lentils:7.17

puts many_orders.inspect 

# order = Grocery::Order.new(1, {"Slivered Almonds" =>2.50, "Wholewheat flour" => 1.00, "Grape Seed Oil" => 100.00})

# order = Grocery::Order.new(10, {})
# puts "Adding Products to first order, apples, cake, and crackers."
# order.add_product("apples", 2.50)
# order.add_product("cake", 2.50)
# order.add_product("crackers", 2.50)
# puts order.inspect
# puts order.total
#
# #support/orders.csv
# #lib/order.rb
# #csv.open('support/orders.csv')
# #to run $rake
# #to run $ruby lib/order.rb
#
#
#
# # puts "Adding Products, apples, cake, and crackers."
# # list.add_product("pears", 2.00)
# # list.add_product("cookies", 2.50)
# # list.add_product("bread", 2.50)
# # puts order.show_order
#
#
#
#
#
#
#
# # puts "\nTrying to asdd crackers a second time"
# # order.add_product("crackers", 2.50)
# #
# # puts order.inspect
# # puts order.show_order
# #
# # puts 'Removing crackers'
# # puts order.remove_product("crackers")
# # puts "Trying to remove crackers again"
# # puts order.remove_product("crackers")
# #
# #
# # puts order.inspect

# CSV.open('../support/orders.csv', 'r').each do |line|
#   id = line[0].to_i#convert order ids to integers
#
#   x = line[1].split(';') #items split by semi colon
#   x.each do |item|
#     y = item.split(":") #each item split by color
#     y.each do |element|
#       items[element[0]] = element[1].to_f
#     end
#     # planets << Planet.new(line[1], line[2], line[3])
#     #   many_orders << Grocery::Order.new(id, items)
#     puts "y is #{y}"
#   end
