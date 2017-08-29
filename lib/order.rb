

require 'csv'
require 'pry'

module Grocery
  class Order
    attr_reader :id
    attr_accessor :products

    def initialize(id, products = 0)
      @id = id
      @products = products
    end

    def add_product(product_name, product_price)

      if @products.include?(product_name)
        return false
      else
        @products[product_name] = product_price
        return true
      end
    end

    def total
      sum = 0
      @products.each do |key, value|
        sum += value.to_f     #changed this to .to_f in case a string gets entered
      end
      sum_incl_tax = (sum + (sum * 0.075)).round(2)
      return sum_incl_tax
    end

    def self.all

      orders = []
      CSV.open("support/orders.csv", 'r').each do |line|
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

    def self.find(val)
      orders = Order.all

      found_order = nil
      orders.each do |order|
        if order.id == val
          found_order = order
        end
      end
      if found_order == nil
        raise ArgumentError.new("Invalid order #{val}")
      else
        return found_order
      end
    end
  end
end
