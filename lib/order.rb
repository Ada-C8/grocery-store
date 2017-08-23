require 'csv'
require 'pry'


module Grocery
  class Order
    attr_reader :id, :products
    TAX = 0.075

    def initialize(id, products)
      @id = id
      @products = products
      @total = 0
    end

    def self.all
      #returns an array of Order instances
      all_orders = []

      CSV.open("support/orders.csv", "r").each do |row|
        #1st, create a hash of the products of each order
        #2nd, create a new Order object, with the id and newly created products hash
        id = row[0].to_i

        product_info = row[1].gsub(":", ",").gsub(";", ",").split(",")

        order_products = {}
        idx = 0
        while idx < product_info.length
          order_products[product_info[idx]] = product_info[idx + 1].to_f
          idx += 2
        end

        order = Order.new(id, order_products)
        all_orders << order

      end

      return all_orders

    end

    def self.find(id)
      #reutnrs an instance of Order where the value of the id field in the CSV
      #matches the passed parameter

      self.all.each do |order|
        if order.id == id
          return order
        else
          return "Sorry, we don't have a matching order for that ID number"
        end
      end

    end

    def total
      # TODO: implement total
      pretax_total = 0

      @products.each do |product, price|
        pretax_total += price
      end

      @total = pretax_total + (pretax_total * TAX).round(2)

      return @total

    end

    def add_product(product_name, product_price)
      # TODO: implement add_product
      # I will check for case once I know how the product names are stored in the CSV
      unless @products.keys.include?(product_name)
        @products[product_name] = product_price
        return true
      end

      return false
    end

    def remove_product(product_name)
      #potentially, check for case
      if @products.keys.include?(product_name)
        @products.delete(product_name)
        return true
      end

      return false
    end

  end
end






##### old way to do self.all below
# def self.all
#   #returns an array of Order instances
#   all_orders = []
#
#   CSV.open("support/orders.csv", "r").each do |row|
#     #1st, create a hash of the products of each order
#     #2nd, create a new Order object, with the id and newly created products hash
#
#     #replace semicolons and colons with comma
#     all_commas = row.gsub(":;", ",")
#
#     #split all order info into an array by comma
#     order_info_array = all_commas.split(",")
#
#     id = order_info_array[0]
#
#     order_products = {}
#     idx = 0
#
#     while idx < order_info_array.length
#       order_products[order_info_array[idx]] = order_info_array[idx + 1].to_f
#     end
# #
# #     #  OLD METHOD ###initial split by semicolon
# #     #  #start at index 2 because of the commma at the beginning
# #     #  products_semi_split = row[2..-1].split(";")
# #     #
# #     #  #second split, by colon
# #     #  products_colon_split = []
# #     #  products_semi_split.each do |product_split|
# #     #    products_colon_split << product_split.split(":")
# #     #  end
# #     #
# #     #
# #     #  products_flattened = products_colon_split.flatten!
# #     #
# #     #  order_products = {}
# #     #
# #     #  idx = 0
# #     #  while idx < products_flattened.length
# #     #    order_products[products_flattened[idx]] = products_flattened[idx+1].to_f
# #     #    idx += 2
# #     #  end
#
#     order = Order.new(id, order_products)
#
#     all_orders << order
#   end
#
#   return all_orders
#
# end
