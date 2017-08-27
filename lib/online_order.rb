require 'CSV'
require_relative 'order.rb'
require_relative 'customer.rb'
module Grocery
    #Inherit from Order class
  class OnlineOrder < Order
    attr_reader :id, :products, :customer_id, :status
    #Instance of customer class will be used within each instance of OnlineOrder
      #customer = Customer.new(id, email, address, city, state, zip)
    #additional attributes:
      #customer object
      #fulfillment status stored as :symbol
        #pending, paid, processing, complete
        #default status :pending

    #updated funcionality:
      #total method same but add $10 shipping fee
      #add_product method updated to permit a new product to be added
        #only if status is either pending or paid otherwise raise ArugmentError

    #should have follwing class methods:

      def initialize(id, products, customer_id, status)
        super(id, products)
        Grocery::Customer.all
        customer_object = Grocery::Customer.find(customer_id.to_i)
        @customer_id = customer_object
        @status = status
      end

      def self.all
        @@online_order_objects = []
        @@line_count = 0
        CSV.open("support/online_orders.csv", 'r').each do |line|
          product_hash ={}
          product_array = line[1].split(';')
          product_array.each do |info|
            smaller_array = info.split(':')
            product_hash[smaller_array[0]] = smaller_array[1]
          end
          id = line[0] = id
          products = product_hash
          customer_id = line[2]
          status = line[3].to_sym
          @@line_count += 1
          @@online_order_objects << OnlineOrder.new(id, products, customer_id, status)
        end
        return @@online_order_objects
      end

      def self.line_count
        return @@line_count
      end

      def self.find(id)
        #returns instance of OnlineOrder with passed id
        #what is diff about this find method vs Order.find?
      end

      def self.find_by_customer(customer_id)
        #returns a list of OnlineOrder instances where value of customers id
          #matches customer_id(passed)
      end


    end
end
