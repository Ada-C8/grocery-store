
require 'csv'
require_relative 'order.rb'
require_relative 'customer.rb'

module Grocery
  class OnlineOrder < Order
    attr_reader :customer, :status, :customer_id, :products_list
    @@online_orders = []

    def initialize(id, collection, customer, status)
      @id = id
      @products_list = collection
      @customer = Grocery::Customer.find(customer)
      @customer_id = customer
      @status = status
    end

    def self.all
      if @@online_orders.any?
        return @@online_orders
      end


      CSV.open('./support/online_orders.csv', 'r',
      headers: true).each do |line|
        list = {}
        order_id = line["id"].to_i
        status = line["status"].to_sym
        customer_id = line["customernum"].to_i
        orders = line["order"].split(";")

        orders.each do |item_pair|
          products = item_pair.split(":")
          list[products[0]] = products[1]
        end
        @@online_orders.push(OnlineOrder.new(order_id, list, customer_id, status))
      end
      return @@online_orders
    end

    def self.find(id_input)
      if id_input > @@online_orders.length
        raise ArgumentError.new("That id doesn't exist")
      end

      all.each do |online_order|
        if id_input == online_order.id
          return online_order
        end
      end
    end

    def self.find_by_customer(customer_id)
      customers_orders = []
      all.each do |order|
        if order.customer_id == customer_id
          customers_orders.push(order)
        end
      end
      return customers_orders
    end

    def add_product(name, price)
      @no_action = [:shipped, :processing, :complete]
      @action = [:paid, :pending]

      if @no_action.include?(@status)
        return "Sorry, you cannot add items at this time."

      elsif @action.include?(@status)
        @products_list.update(name => price)
      end

    end



  end
end

# puts "#{Grocery::OnlineOrder.find_by_customer(12)}"
