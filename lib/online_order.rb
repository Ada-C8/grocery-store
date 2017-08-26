# Each new OnlineOrder should include all attributes from the Order class as well as the following additional attributes:
#
# A customer object
# A fulfillment status (stored as a Symbol)
#
#pending, paid, processing, shipped or complete
#
# If no status is provided, it should set to pending as the default
# The OnlineOrder should include the following updated functionality:
#
# The total method should be the same, except it will add a $10 shipping fee

# The add_product method should be updated to permit a new product to be added ONLY if the status is either pending or paid (no other statuses permitted)
# Otherwise, it should raise an ArgumentError (Google this!)

# The OnlineOrder should also have the following class methods:
#
# self.all - returns a collection of OnlineOrder instances, representing all of the OnlineOrders described in the CSV. See below for the CSV file specifications
# Question Ask yourself, what is different about this all method versus the Order.all method? What is the same?
# self.find(id) - returns an instance of OnlineOrder where the value of the id field in the CSV matches the passed parameter. -Question Ask yourself, what is different about this find method versus the Order.find method?
# self.find_by_customer(customer_id) - returns a list of OnlineOrder instances where the value of the customer's ID matches the passed parameter.

require_relative 'order'
require 'csv'
require 'pry'

module Grocery
  class OnlineOrder < Order
    attr_reader :customer_id
    attr_accessor :status
    def initialize(id, products, customer_id, status = :pending)
      super(id, products)
      @customer_id = customer_id
      @status = status.to_sym
    end

    def self.all
      @online_orders = []
      CSV.open("support/online_orders.csv", 'r').each do |line|
        #line.split(",")

        id = line[0].to_i
        customer_id = line[2].to_i
        status = line[3].to_sym
        products_hash = {}
        products_arr = line[1].split';'

        products_arr.each do |item_and_price|
          product_price = item_and_price.split':'
          products_hash[product_price[0]] = product_price[1].to_f
        end
        @online_orders << self.new(id, products_hash, customer_id, status)
      end
      return @online_orders
    end

    def self.find_by_customer(val)
      all_online_orders = Grocery::OnlineOrder.all

      customer_order = nil
      customer_orders = []

      all_online_orders.each do |order|
        if order.customer_id == val
          customer_order = order
          customer_orders << customer_order
        end
      end
      if customer_order == nil
        raise ArgumentError.new("Invalid order #{val}")
      else
        return customer_orders
      end
    end


    def total
      super + 10 #adds $10 shipping fee
    end

    #This doesn't work yet. Once have self.all method, try updating and try again
    def add_product(product_name, product_price)
      unless Grocery::OnlineOrder.status == :pending
        raise ArgumentError.new("Due to order status, additional products can no longer be added to the order.")
      end
      super(product_name, product_price)

    end

  end

end
