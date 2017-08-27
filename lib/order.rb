require 'csv'

module Grocery
  class Order
    attr_reader :id, :products

    def initialize(id, products)
      @id = id
      @products = products
    end

    def self.all
      all_orders = []
      CSV.open("support/orders.csv", "r").each do |line|
        id = line[0]
        product = line[1]
        instance_order = Order.new(id, string_product_to_hash(product))
        all_orders << instance_order
      end
      return all_orders
    end

    def self.string_product_to_hash(string_product)
      #Slivered Almonds:22.88;Wholewheat flour:1.93;Grape Seed Oil:74.9
      hash_products = {}
      result = string_product.split(";")
      result.each do |i|#Slivered Almonds:22.88
        name_and_price = i.split(":")
        name = name_and_price[0]
        hash_products[name] = name_and_price[1].to_f
      end

      return hash_products
    end


    def total
      total = 0
      @products.each do | name, value|
        sum = value + (value * 0.075).round(2)
        total = total + sum
      end
      return total
    end

    def add_product(product_name, product_price)
      if !@products.include?(product_name)
        @products[product_name] = product_price
        return true
      else
        return false
      end
    end

    def remove_product(product_name)
      if @products.include?(product_name)
        @products.delete(product_name)
        return true
      else
        return false
      end
    end

    def self.find(id)
      all_orders = Order.all
      all_orders.each do |order|
        if order.id == id
          return order
        end
      end
      throw ArgumentError.new("Order not found.")
    end
  end
end
