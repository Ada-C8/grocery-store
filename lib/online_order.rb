require 'CSV'
require_relative 'order.rb'
require_relative 'customer.rb'
module Grocery
  class OnlineOrder < Order
    attr_reader :id, :products, :customer_id, :status, :customer_list

    def initialize(id, products, customer_id, status = :pending)
      super(id, products)
      Grocery::Customer.all
      customer_object = Grocery::Customer.find(customer_id.to_i)
      @customer_id = customer_object
      @status = status
      @id = id
      @status = status
    end

    def self.all
      @@online_order_objects = []
      @@online_line_count = 0
      CSV.open("support/online_orders.csv", 'r').each do |line|
        product_hash ={}
        product_array = line[1].split(';')
        product_array.each do |info|
          smaller_array = info.split(':')
          product_hash[smaller_array[0]] = smaller_array[1]
        end
        id = line[0]
        products = product_hash
        customer_id = line[2]
        status = line[3].to_sym
        @@online_line_count += 1
        @@online_order_objects << OnlineOrder.new(id, products, customer_id, status)
      end
      return @@online_order_objects
    end

    def self.online_line_count
      return @@online_line_count
    end

    def self.find(id)
      @@online_order_objects.each do |object|
        if object.id.to_i == id.to_i
          return object
        end
      end
      raise ArgumentError.new("That is not an existing online order")
    end

    def self.find_by_customer(customer_id)
      self.all
      @customer_list = []
      @@online_order_objects.each do |object|
        if object.customer_id.id.to_i == customer_id
          @customer_list << object
        end
      end
      return @customer_list
    end

    def total
      if @products.length>0
        super + 10
      else
        0.0
      end
    end

    def add_product(product_name, product_price)
      if @status == :pending || status == :paid
        super
      else
        raise ArgumentError.new("Cannot modify processing, shipped, or completed orders")
      end
    end
  end
end
