require_relative 'order'
require_relative 'customer'
require 'csv'

module Grocery

  class OnlineOrder < Order

    attr_reader :id, :products, :customer, :status

    def initialize(id, products = 0, customer_id, status)
      @id = id
      @products = products
      @customer = Grocery::Customer.find(customer_id)
      @status = status
    end

    def total
      if @products != 0
        super + 10
      else 0
      end
    end

    def add_product(product_name, product_price)
      case @status
      when :pending, :paid
        super
      when :complete, :shipped, :processing
        raise ArgumentError.new "Cannot add prodcut to complete, shipped or processing online orders"
      end
    end

    def self.all
      all_orders =[]
      CSV.read('support/online_orders.csv').each do |row|
        order_id = row[0]
        order_cust_id = row[2]
        order_status = row[3].to_sym
        order_products_hash = {}
        product_row = row[1].split(";")
        product_row.each do |pair|
          pairs = pair.split(":")
          order_products_hash[pairs[0]] = pairs[1]
        end # end of product_row
        all_orders.push(Grocery::OnlineOrder.new(order_id, order_products_hash, order_cust_id, order_status))
      end #end of csv
      return all_orders
    end # end of all

    def self.find_by_customer(input_id)
      customer_orders = []
      all_orders = self.all
      all_orders.each do |order|
        order_customer = order.customer
        if order_customer.id == input_id
          customer_orders.push(order)
        end
      end
      if customer_orders.length == 0
        raise ArgumentError.new "No orders were found with that Customer ID"
      else
        return customer_orders
      end
    end #end of find_by_customer
  end #end of class
end #end of module
