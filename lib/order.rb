
require 'csv'

module Grocery
  class Order
    @@all_orders = Array.new

    attr_reader :id, :products

    def initialize(id, products)
      @id = id.to_i
      @products = products
      @total = 0
    end #initialize

    def self.all_orders
      return @@all_orders
    end

    def self.all
      @@all_orders = []
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
        @@all_orders << Grocery::Order.new(id, products)
        products = {} #clears the products array for the next order.
      end #of CSV line by line
      return @@all_orders
    end

    def self.find(id)
      orders = Grocery::Order.all
      item_num = []

      orders.each do |item|
        item_num << item.id
      end

      if item_num.include?(id)
        return orders[id - 1]
      else
        raise ArgumentError, "ID Number Not Found"
      end
    end# method def

    def total
      pretax = 0
      @products.each_value do |value|  # summing up the products
        pretax += value
      end #each item calculation
      @total = pretax + (0.075 * pretax).round(2) # adding a 7.5% tax # ensure the result is rounded to two decimal places
      return  @total
    end #total method

    def add_product(product_name, product_price)
      if @products.keys.include?(product_name)
        return false     # and false if it was not
      else
        @products[product_name] = product_price
        return true #@products     # It should return true if the item was successfully added
      end
    end #add_product method

    def remove_product(product_name)
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
