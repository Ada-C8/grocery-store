
require 'pry'
#mix-in ??? include module
require_relative '../lib/order'


module Grocery

  class OnlineOrder < Order
    # include Grocery::Customer

    attr_reader :id, :products, :customer, :status


    def initialize(id,products,customer,status= :pending)
      super(id,products)
      # @id = id
      # @products = products
      @customer = customer #return customer by customer id?
      @status = status
      # @total = 0
    end #end initialize


    def self.all # should I define a method that creates a hash/array of all object information? Self.all would then iterate through the array of object information, create the Object instance as relevant, and return an array of all the newly created objects
      # super(csv_file = "support/online_orders.csv")

      all_online_orders = []
      csv_file = "support/online_orders.csv"

      CSV.open(csv_file, "r").each do |row|
        id = row[0].to_i
        product_info = row[1].gsub(":", ",").gsub(";", ",").split(",")
        customer_id = row[-2].to_i
        status = row[-1].to_sym #check to see if all online_orders have a status, must be one of the four valid statuses

        online_order_products = {}
        idx = 0

        while idx < product_info.length
          online_order_products[product_info[idx]] = product_info[idx + 1].to_f
          idx += 2
        end

        order = OnlineOrder.new(id, online_order_products,Grocery::Customer.find(customer_id),status)
        all_online_orders << order

      end

      return all_online_orders

    end #end self.all

  binding.pry

    def total
      @total = super + 10 # shipping fee?
    end

    def add_product(product_name, product_price)
      # TODO: implement add_product
      # I will check for case once I know how the product names are stored in the CSV

      if @status == :pending || @status == :paid
        unless @products.keys.include?(product_name)
          @products[product_name] = product_price
          return true
        end
        raise ArgumentError.new("You already have that product.")
      end

      raise ArgumentError.new("You can't add products to a paid or pending order")
    end

    def self.find(id)
      super
    end

    def self.find_by_customer(customer_id)
      #returns a list of Online Order instances of all online orders that match the customer's id
      #check if cystomer id and id for find are strings or integers, make sure they match type
      customers_orders = []
      self.all.each {|online_order| customers_orders << online_order if online_order.customer.id == id}

      raise ArgumentError.new "Sorry, we don't have an order matching that customer ID number." if customers_orders.empty?

      return customers_orders
    end



  end #Online Order class

end #end Grocery module

# binding.pry
