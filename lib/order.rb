require 'csv'
require 'pry'
require 'awesome_print'
# do i need to require_relative anything from customer and online_order here???

module Grocery
  class Order
    attr_reader :id, :food_and_price, :total, :all_orders, :orders

    def initialize(id, food_and_price)
      @id = id
      @food_and_price = food_and_price
    end


    def self.all(file_name)
      @orders = []
      CSV.open(file_name, "r").each do |row|
        @food_and_price = {}
        @id = row[0].to_i
        @product_list = row[1].split(";")
        @product_list.each do |sep|
          food_price_array = sep.split(":")
          @food_and_price[food_price_array[0].to_s] = food_price_array[1].to_f
        end
        @orders << Grocery::Order.new(@id, @food_and_price)
      end
      return @orders
    end

    def self.find(file_name, id)
      self.all(file_name).each do |instance|
        if instance.id == id
          return instance
        end
      end
      raise ArgumentError.new "Invalid Order Number"
    end

    def total
      sum = 0
      @food_and_price.values.each do |price|
        sum += price
      end
      total = sum + (sum * 0.075).round(2)
    end

    def add_product(product_name, product_price)
      unless @food_and_price.has_key?(product_name)
        @food_and_price[product_name] = product_price
        return true
      else
        return false
      end
    end

    def remove_product(product_name)
      if @food_and_price.has_key?(product_name)
        @food_and_price.delete(product_name)
        return true
      else
        return false
      end
    end
    
  end
end

#
# all_the_orders = Grocery::Order.all("./support/orders.csv")
# #
# ap all_the_orders

# order = Grocery::Order.find("./support/orders.csv", 1)
#
# puts order.id
# puts order.id
