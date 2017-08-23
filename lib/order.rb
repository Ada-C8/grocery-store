# Update the Order class to be able to handle all of the fields from the CSV file used as input
# To try it out, manually choose the data from the first line of the CSV file and ensure you can create a new instance of your Order using that data
# Add the following class methods to your existing Order class
# self.all - returns a collection of Order instances, representing all of the Orders described in the CSV. See below for the CSV file specifications
# Determine if the data structure you used in Wave 1 will still work for these new requirements
# Note that to parse the product string from the CSV file you will need to use the split method
# self.find(id) - returns an instance of Order where the value of the id field in the CSV matches the passed parameter.
require 'csv'

module Grocery
  class Order
    @@all_orders = []
    attr_reader :id, :products

    def initialize(id, products)#products is a hash with item => price
      @id = id.to_i
      @products = products
      @total = 0
    end #initialize

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
items = {}
CSV.open('../support/orders.csv', 'r').each do |line|
  id = line[0].to_i#convert order ids to integers
  x = line[1].split(';')
  x.each do |item|
    y = item.split(":")
    y.each do |element|
      items[y[0]] = y[1].to_f
    end
  end
  order = Grocery::Order.new(id, items)
  many_orders << order
end

puts many_orders.length
# CSV.open("planet_data.csv", 'r').each do |line|
#   #Make a new planet, using the variable 'line', push to planets array.
#   puts line.class
#   planets << Planet.new(line[1], line[2], line[3])
# end



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
