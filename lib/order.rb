##### Qs: what is the purpose of the id?
# should there be an array of hashes to store what the store has already?
# should I initialize price (Why only id and products?)
# how to add to product list?
require 'csv'
module Grocery
  class Order
    attr_reader :id, :products
    @@all_orders = []

    def initialize(id, products)
      @id = id
      @products = products

    end # end of initialize
    # zero products is permitted
    # you can assume that there is only one of each product

    def total
      add_product = 0
      @products.each_value do |cost|
        add_product  += cost
      end
      total = (add_product + (add_product * 0.075))
      return total.round(2)
    end # total method

    # @products.each do |product, values|
    #   sum = @products.values.inject(0, :+)
    #   return (sum + (sum * 0.075).round(2))
    # end # products loop

    def add_product(product_name, product_price)
      if @products.key?(product_name) == true
        return false
      elsif
        @products[product_name] = product_price
        return true
      end # conditional
    end # add_product method

    def remove_product(product_name)
      if @products.key?(product_name) == true
        @products.delete(product_name)
        return true
      else
        return false
      end
    end

    def self.all
      if @@all_orders.length > 0
        return @@all_orders
      end
      CSV.open("../support/orders.csv", 'r').each do |line|
        id = line[0].to_i
        # playing with .sub!
        # line[1] = line[1].gsub! ';', ','
        # line[1] = line[1].gsub! ':', '=>'
        products = {}
        products_arr = line[1].split';'
        products_arr.each do |item|
          product_price = item.split':'
          products[product_price[0]] = product_price[1].to_f
        end
        @@all_orders << self.new(id, products)
      end # each loop
      return @@all_orders
    end # self.all method

    def self.find(id)
      # orders = self.all
      if id > all.length
        raise ArgumentError.new("Error: #{id} does not exist")
      end

      Order.all.each do |order|
        if order.id == id
          return order
        end
      end

    end # end self.find method
  end # Order class
end # Grocery module


# test = Grocery::Order.new
# puts test.find(2)

# products = { "banana" => 1.99, "cracker" => 3.00 }
# test_order = Grocery::Order.new(1337, products)
#
# puts test_order.total
#
#
# test_order.add_product("sandwich", 4.25)
# puts test_order.products
# puts test_order.total
# test_order.remove_product("sandwich")
# puts test_order.products
