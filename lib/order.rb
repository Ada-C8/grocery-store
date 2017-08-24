require 'csv'

module Grocery
  class Order
    @@all_orders = Array.new

    attr_reader :id, :products

    def initialize(id, products)#products is a hash with item => price
      @id = id.to_i
      @products = products
      @total = 0
    end #initialize

    def self.all
      products = {}
      #file.each do |line|
      CSV.open('../support/orders.csv', 'r').each do |line|
        id = line[0].to_i
        x = line[1].split(';')
        x.each do |item|
          y = item.split(":")
          x.length.times do
            products[y[0]] = y[1].to_f
          end
        end #of x.each do
        @@all_orders << Grocery::Order.new(id, products)
        products = {}
      end #of CSV line by line
      return @@all_orders
    end

    def self.find(id)
      products = {}
      x = []
      CSV.open('../support/orders.csv', 'r').each do |line|
        if id.to_i == line[0].to_i #begin if statement
          x = line[1].split(';')
          break
        end # if statement
      end #of CSV line by line
      if x == []
        z = "there's nothing to see here"
        return z
        #raise ArgumentError.new("Order Not Found")
      else
        x.each do |item| #begin split by :
          y = item.split(":")
          x.length.times do #begin adding products to the hash
            products[y[0]] = y[1].to_f
          end #end adding products to hash
        end #end split by :
        return Grocery::Order.new(id, products)
      end #second if statement
    end# method def

    def self.all_orders
      return @@all_orders
    end

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


# puts "____________________________________"
# #puts Grocery::Order.all(many_orders)
# x = Grocery::Order.all
# puts Grocery::Order.find(10).show_order
# puts Grocery::Order.find(150)
# puts Grocery::Order.find(20).show_order

# puts x.length

# order2 = Grocery::Order.new(10, {})
# puts order2.class

#id = 1337
# many_orders = []
# products = {}
#
# CSV.open('../support/orders.csv', 'r').each do |line|
#   id = line[0].to_i
#   x = line[1].split(';')
#   x.each do |item|
#     y = item.split(":")
#     x.length.times do
#       products[y[0]] = y[1].to_f
#     end
#   end #of x.each do
#     many_orders << Grocery::Order.new(id, products)
#     products = {}
# end #of CSV line by line


#puts many_orders.inspect
# many_orders.each do |thing|
#   puts "#{thing.id}: #{thing.products}"
# end
# order = Grocery::Order.new(1, {"Slivered Almonds" =>2.50, "Wholewheat flour" => 1.00, "Grape Seed Oil" => 100.00})


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

# many_orders = []
# products = {}
#
# CSV.open('../support/orders.csv', 'r').each do |line|
#   id = line[0].to_i
#   x = line[1].split(';')
#   #puts "x is #{x} and it is class #{x.class}"
#
#   x.each do |item|
#     y = item.split(":")
#     #puts "y is #{y} and it is #{y.class}\n\n"
#     x.length.times do
#       products[y[0]] = y[1]
#     end
#
#     puts "products is now #{products}"
#     puts "*****************"
#   end #of x.each do
#   puts "WHDHFSDFOIJWEOIFEWOIFNOIEWNFEOI"
#     many_orders << Grocery::Order.new(id, products)
#     products = {}
# end #of CSV line by line
# puts "____________________________________"
#
# def self.all(all_orders)
#   list = ""
#   all_orders.each do |thing|
#     puts "#{thing.id}: #{thing.products}"
#   end
#   return list
# end #self.all method

# list = ""
# @@all_orders.each do |thing|
#   puts "#{thing.id}: #{thing.products}"
# end
# return list
