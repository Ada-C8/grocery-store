# Create a Grocery module which will contain an Order class and any future grocery store logic.
# Create an Order class which should have the following functionality:
# Update the Order class to be able to handle all of the fields from the CSV file used as input

require 'csv'

module Grocery
  class Order
    @@all_orders = Array.new

    attr_reader :id, :products  # A new order should be created with:an ID, read-only

    def initialize(id, products)#products is a hash with item => price
      @id = id
      @products = products   # a collection of products and their cost zero products is permitted
      #you can assume that there is only one of each product
      @total = 0
    end #initialize

    def self.all # self.all - returns a collection of Order instances, representing all of the Orders described in the CSV. See below for the CSV file specifications
      products = {}
      CSV.open('../support/orders.csv', 'r').each do |line|
        id = line[0].to_i #assigns first # in CSV to be the order ID
        semi_colon_split = line[1].split(';') #splits the orders by semicolons
        semi_colon_split.each do |item|
          colon_split = item.split(":") #seperates product name and price
          semi_colon_split.length.times do
            products[colon_split[0]] = colon_split[1].to_f #adds product name and price to products hash
          end
        end #of x.each do
        @@all_orders << Grocery::Order.new(id, products) #initalizes a new order using the id and products hash for the current line and adds it to all orders array
        products = {} #clears the products array for the next order.
      end #of CSV line by line
      return @@all_orders
    end

    def self.looksy(id)
      # self.find(id) - returns an instance of Order where the value of the id field in the CSV matches the passed parameter.
      orders = Grocery::Order.all_orders
      item_num = []

      orders.each do |item|
        item_num << item.id
      end

      if item_num.include?(id)
        return orders[id - 1].products
      else
        return "Item Not Found"
      end
            #return Grocery::Order.all_orders[id].products
    end# method def




      # CSV.open('../support/orders.csv', 'r').each do |line|
      #   if id.to_i == line[0].to_i #begin if statement
      #     found = line[1].split(';')
      #     break
      #   end # if statement
      # end #of CSV line by line
      #
      # if found == []
      #   z = "there's nothing to see here"
      #   return z
      #   #raise ArgumentError.new("Order Not Found")
      # else
      #   found.each do |item| #begin split by :
      #     colon_split = item.split(":")
      #     found.length.times do #begin adding products to the hash
      #       products[colon_split[0]] = colon_split[1].to_f
      #     end #end adding products to hash
      #   end #end split by :
      #   return Grocery::Order.new(id, products)
      # end #second if statement


    def self.all_orders
      return @@all_orders
    end

    def total # A total method which will calculate the total cost of the order by:
      pretax = 0
      @products.each_value do |value|  # summing up the products
        pretax += value
      end #each item calculation
      @total = pretax + (0.075 * pretax).round(2) # adding a 7.5% tax # ensure the result is rounded to two decimal places
      return  @total
    end #total method

    def add_product(product_name, product_price)  # An add_product method which will take in two parameters, product name and price, and add the data to the product collection
      if @products.keys.include?(product_name)
        return false     # and false if it was not
      else
        @products[product_name] = product_price
        return true #@products     # It should return true if the item was successfully added
      end
    end #add_product method

    def remove_product(product_name)   # Add a remove_product method to the Order class which will take in one parameter, a product name, and remove the product from the collection
      if @products.keys.include?(product_name)
        @products.delete(product_name)
        return true # It should return true if the item was successfully remove and false if it was not
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



order = Grocery::Order.all

puts Grocery::Order.looksy(1000)
#puts order[15].products
#puts order.find(10)
# puts order.class
# puts order.length
# puts order[10].id
# puts order[10].products
# item_num = []
#
# order.each do |item|
#   item_num << item.id
# end
#
# if item_num.include?(150)
#   puts order[0].products
# else
#   puts "Item Not Found"
# end







# puts order.length
#
# x = Grocery::Order.new(12, {"apples"=>5.00, "pears"=>15.00})
# puts x.inspect
# puts x.total
# puts x.id
# puts x.products
# puts x.total
