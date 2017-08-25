require 'csv'
require 'pry'
require 'awesome_print'
require_relative 'order.rb'

module Grocery
  class OnlineOrder < Order

    attr_reader :id, :all_online_orders, :food_and_price, :status, :customer_id

    def initialize(id, food_and_price, customer_id, status)
      @id = id
      @food_and_price = food_and_price
      # super
      @customer_id = customer_id
      @status = status
    end

    def self.all(file_name)
      @all_online_orders = []
      CSV.open(file_name, "r").each do |row|
        @food_and_price = {}
        @id = row[0].to_i
        @customer_id = row[2].to_i
        @status = row[3].to_sym
        @items = row[1].split(";")
        @items.each do |sep|
          food_price_array = sep.split(":")
          @food_and_price[food_price_array[0].to_s] = food_price_array[2].to_f
        end
        @all_online_orders << Grocery::OnlineOrder.new(@id, @food_and_price, @customer_id, @status)
      end
      return @all_online_orders
    end

    def self.find(file_name, id)
      self.all(file_name).each do |instance|
        if instance.id == id
          return instance
        end
      end
      raise ArgumentError.new "Invalid Order Number"
    end
  end
end

  # all_the_online_orders = Grocery::OnlineOrder.all("./support/online_orders.csv")
  #
  # ap all_the_online_orders

  order = Grocery::OnlineOrder.find("./support/online_orders.csv", 1)

  puts order.id 
