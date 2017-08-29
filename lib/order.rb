# Requirements
#
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

# Optional:
#
# Make sure to write tests for any optionals you implement!
#
# Add a remove_product method to the Order class which will take in one parameter, a product name, and remove the product from the collection
# It should return true if the item was successfully remove and false if it was not
require 'awesome_print'
require 'csv'
require 'pry'

module Grocery
  class Order
    attr_reader :id, :products

    def initialize(id, products)
      @id = id
      @products = products
    end

    def self.all
      orders_array = []
      ind_order_array = []

      # csv = CSV.read("support/orders.csv")
      # ap csv.length
      CSV.open("support/orders.csv", 'r').each do |line|
        # ap line
        ind_order_array << line
        # ap "ind_orders_array : #{ind_orders_array}"
        id = line[0].to_i
        product_array = line[1].split(';') # array of product:price

        items = {}
        product_array.each do |element_pair|
           item = element_pair.split(':') # array [0]item, [1]price
           items[item[0]] = item[1].to_f
        end

        orders_array << Order.new(id, items)
        # binding.pry
        # ap orders
      end
      return orders_array
    end

    def self.find(id)
      # if all[0].id == 1
      all.each do |order|
        if order.id == id
          return order
        end
      end
        # return order

    end

    def total
      # TODO: implement total
      # total = sum of product + 7.5% sales tax
      tax_rate = 0.075
      product_sum = 0

      products.each do |k, v|
        product_sum = product_sum + v
      end
      sales_tax = product_sum * tax_rate
      total = product_sum + sales_tax
      return total.round(2)
    end

    def add_product(product_name, product_price)
      # TODO: implement add_product
      if products.has_key?(product_name)
        return false
      else
        products.merge!(product_name => product_price)
        return true
      end
    end

    def remove_product(product_name)
      # TODO: remove the product from the collection, return true if item was removed, return false if not
      if products.has_key?(product_name)
        products.delete(product_name)
        return true
      else
        return false
      end
    end
  end
end

# order = Grocery::Order.new(1223, {"banana" => 1.99, "cracker" => 3.00 })
# order = Grocery::Order.all
# puts order.total
ap Grocery::Order.find(3)
