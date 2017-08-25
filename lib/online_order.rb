require 'csv'
require 'pry'
require 'awesome_print'
require_relative 'order.rb'

module Grocery
  class OnlineOrder < Order

    attr_reader :id, :all_online_orders, :food_and_price, :status

    def initialize(id, food_and_price, status)
      @id = id
      @food_and_price = food_and_price
      @status = status
    end

    def self.all(file_name)
      @all_online_orders = []
      CSV.open(file_name, "r").each do |row|
        @food_and_price = {}
        @id = row[0].to_i
        @items = row[1].split(";")
        @items.each do |sep|
          food_price_array = sep.split(":")
          @food_and_price[food_price_array[0].to_s] = food_price_array[2].to_f
          @status = row[2]
        end
        @all_online_orders << Grocery::OnlineOrder.new(@id, @food_and_price, @status)
      end
      return @all_online_orders
    end

  end
end

all_the_online_orders = Grocery::OnlineOrder.all("./support/online_orders.csv")

ap all_the_online_orders
