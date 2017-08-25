require 'csv'
require 'pry'
require 'awesome_print'
require_relative 'order.rb'
require_relative 'customer.rb'

module Grocery
  class OnlineOrder < Order

    attr_reader :id, :all_online_orders, :food_and_price, :status, :customer_id, :customer_object

    def initialize(id, food_and_price, customer_id, status)
      @id = id
      @food_and_price = food_and_price
      # super
      # is this what I'm supposed to be doing here??
      @customer_id = customer_id
      # @customer_object = Grocery::Customer.find("../support/customers.csv", @customer_id)
      @status = status
    end

    def self.all(file_name)
      @all_online_orders = []
      CSV.open(file_name, "r").each do |row|
        @food_and_price = {}
        @id = row[0].to_i
        @customer_id = row[2].to_i
        # @customer_object = Grocery::Customer.find("./support/customers.csv", @customer_id)
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


# def self.find_by_customer(file_name, customer_id)
#   list_by_customer = ""
#   self.all(file_name).each do |instance|
#     if instance.customer_id == customer_id
#       list_by_customer << instance
#     end
#   end
#     if list_by_customer.length > 0
#       return list_by_customer
#     else
#       return "No orders from that customer"
#     end
# end

  all_the_online_orders = Grocery::OnlineOrder.all("./support/online_orders.csv")

  # ap all_the_online_orders

  puts Grocery::OnlineOrder.find("./support/online_orders.csv", 1).status 


  # order = Grocery::OnlineOrder.find_by_customer("./support/online_orders.csv", 1)
  #
  # puts order
