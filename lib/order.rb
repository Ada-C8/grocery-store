# require_relative '../support/orders'
require 'CSV'
module Grocery
  class Order
    attr_reader :id, :products
    def initialize(id, products)
      @id = id
      @products = products
    end



    def self.all
      @@order_objects = []
      @@line_count = 0
      CSV.open("support/orders.csv", 'r').each do |line|
        @@line_count += 1
        id = line[0]
        product_hash ={}
        product_array = line[1].split(';')
        product_array.each do |info|
          smaller_array = info.split(':')
          product_hash[smaller_array[0]] = smaller_array[1]
        end
        @@order_objects << Order.new(id.to_i, product_hash)
      end
      return @@order_objects
    end


    def self.line_count
      return @@line_count
    end

    def self.order_objects
      return @@order_objects
    end


    def self.find(id)
      @@order_objects.each do |object|
        if object.id == id
          return object
        end
      end
      raise ArgumentError.new("That is not an existing order")
    end


    def total
      @total = 0
      @products.each do |product, price|
        @total += price + price*(0.075)
      end
      return @total.round(2)
    end

    def add_product(product_name, product_price)
      @products.each do |product, price|
        if product == product_name
          return false
        end
      end
      @products[product_name] = product_price
      return true
    end

    def remove_product(product_name)
      @original_length = @products.length
      @products.delete(product_name)
      if products.length == @original_length
        return false
      else
        return true
      end
    end
  end
end
