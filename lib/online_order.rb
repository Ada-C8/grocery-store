require 'csv'
require_relative 'order'
require_relative 'customer'

module Grocery
  class OnlineOrder < Order
    attr_reader :status, :customer, :products

    def initialize(id, products, customer_id, status = :pending)
      @id = id
      @products = products
      @customer = Customer.find(customer_id)
      @status = status
      # maybe put in status options there
    end

    def total
      if products != {}
        total = super + 10
      else
        total = super
      end
      return total
    end

    def add_product(product_name, product_price)
      changes_prohibited = [:processing, :shipped, :complete]
      if changes_prohibited.include?(status)
        puts "No changes can be made to the order at this time."
      else
        super
      end
    end


    def self.all
      csv_array_of_all_online_orders = []
      CSV.open("support/online_orders.csv", 'r').each do |line|
        product = Hash.new
        id = line[0].to_i
        status = line[-1]
        customer_id = line[-2].to_i
        all_items_and_prices = line[1...-2]
        item_and_price = all_items_and_prices.to_s.split(";")
        item_and_price.each do |item_and_price|
          item = item_and_price.split(":")[0]
          item = item.delete("[")
          item = item.delete("\"")
          price = item_and_price.split(":")[1]
          price = price.delete("]")
          price = price.delete("\"")
          price
          product[item] = price.to_f
        end
        current_order = [id, product, customer_id, status]
        csv_array_of_all_online_orders << current_order
      end
      all_online_orders = []
      csv_array_of_all_online_orders.each do |online_order|
        all_online_orders << OnlineOrder.new(online_order[0], online_order[1], online_order[2], online_order[3])
      end
      return all_online_orders
    end

    def self.find_by_customer(customer_id)
      one_customer_online_order = []
      all_online_orders = Grocery::OnlineOrder.all
      all_online_orders.each do |one_online_order|
        if one_online_order.customer.customer_id == customer_id.to_s
          one_customer_online_order << one_online_order
        end
      end
      if one_customer_online_order.length > 0
        return one_customer_online_order
      else
        raise ArgumentError.new("Customer number #{customer_id} did not place an online_order.")
      end
    end
  end #end of class
end #end of module

#
