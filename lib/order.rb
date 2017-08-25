require 'csv'
require 'awesome_print'

module Grocery
  class Order
    attr_reader :id, :products
    @@orders = []
    def initialize(id, collection)
      @id = id
      @products = collection
    end

    def self.all
      if @@orders.any?
        return @@orders
      end

      #order = {id => {item:price, item:price}}
      CSV.open("./support/orders.csv", "r").each do |line|
        shopping_list = {}
        id = line[0].to_i
        list = line[1]
        list = list.split(";") #now this is an array
        list.each do |element_pair|
          item = element_pair.split(":")
          shopping_list[item[0]] = item[1]
        end
        @@orders.push(Order.new(id, shopping_list))
      end
      return @@orders
    end

    def self.find(id_input)
      if @@orders.empty?
        all
      end

      if id_input > all.length
        raise ArgumentError.new("That id doesn't exist")
      end

      @@orders.each do |order|
        if order.id == id_input
          return order
        end
      end
    end

    def total
      cost = 0
      @products.each do |item, price|
        cost += @products[item]
      end
      return (cost * 1.075).round(2)
    end

    def add_product(product_name, product_price)
      if @products.include?(product_name)
        return false
      else
        @products[product_name] = product_price
        return true
      end
    end

    def remove_product(name)
      if @products.include?(name)
        @products.delete(name)
        return true
      else
        return false
      end
    end
  end
end
