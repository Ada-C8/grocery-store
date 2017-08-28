module Grocery
  require 'csv'
  class Order
    attr_reader :id, :products

    def initialize(id, products)
      @id = id.to_i
      @products = products
    end

    def total
      # TODO: implement total
      sum = products.values.inject(0, :+)
      return sum + (sum * 0.075).round(2)
    end

    def add_product(product_name, product_price)
      # TODO: implement add_product
      unless @products.has_key?(product_name) # as long as the collection of products doesn't already have the key of the new item, you can add it to the list
        @products[product_name] = product_price
        return true
      else
        return false # otherwise, it isn't unique, and something with that name is already on file.
      end
    end

    def self.all
      all_orders = []
      CSV.open("support/orders.csv", 'r').each do |line|
        id = line[0].to_i
        products = {}
        line[1].split(";").each do |item|
          details = item.split(":")
          products[details[0]] = details[1]
        end
        all_orders << self.new(id, products) # creates new Order Hash after separating each order/product
      end
      return all_orders
    end

    def self.find(id)
      self.all.each do |order|
        if id == order.id
          return order
        end
      end
      raise ArgumentError.new ("Invalid Order ID")
    end
  end
end
