require 'csv'
require_relative 'order'
module Grocery
  class OnlineOrder < Grocery::Order
    attr_reader :customer, :status

    def initialize (id, products, customer, status = :pending)
      super(id, products)
      @customer = customer
      @status = status
      valid_status = [:pending, :paid, :processing, :shipped, :complete]
      if !valid_status.include?status
        throw ArgumentError.new("Invalid status for online order '#{status}''")
      end
    end

    def total
      total = super
      return total + 10
    end

    def add_product(product_name, product_price)
      if @status == :pending || @status == :paid
        super(product_name, product_price)
      else
        raise ArgumentError.new ("New product can not be added!")
      end
    end

    def self.all
      all_online_orders = []
      CSV.open("support/online_orders.csv", "r").each do |line|
        id = line[0]
        product = line[1]
        customer_id = line[2]
        status = line[3].to_sym
        customer = Grocery::Customer.find(customer_id)
        instance_online_order = OnlineOrder.new(
          id,
          string_product_to_hash(product),
          customer,
          status)
        all_online_orders << instance_online_order
      end
      return all_online_orders
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

    def self.find(id)
      all_online_orders = OnlineOrder.all
      all_online_orders.each do |order|
        if order.id == id
          return order
        end
      end
      throw ArgumentError.new("Order not found.")
    end

    def self.find_by_customer(customer_id)
      all_online_orders = OnlineOrder.all
      all_online_orders.each do |order|
        if order.customer.id == customer_id
          return order
        end
      end
      throw ArgumentError.new("Not found.")
    end
  end
end
