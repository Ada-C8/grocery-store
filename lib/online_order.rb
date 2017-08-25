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
        id = line[0]
        status = line[-1]
        customer_id = line[-2]
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



  end #end of class
end #end of module

#
# id = 13
# products = { "banana" => 1.99, "cracker" => 3.00 }
# customer_id = 1
# status = :pending
# new_online_order = Grocery::OnlineOrder.new(id, products, customer_id, status)
#
# puts new_online_order.customer.email
# #puts new_online_order.total
