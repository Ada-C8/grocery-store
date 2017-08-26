
require 'pry'
#note: look up mix-in ??? look up include module
# require_relative '../lib/order'


module Grocery

  class OnlineOrder < Order
    # include Grocery::Customer

    attr_reader :id, :products, :customer, :status


    def initialize(id,products,customer,status= :pending)
      super(id,products)
      @customer = customer #return customer object by customer id
      @status = status
    end

    def self.all

      all_online_orders = []
      all_online_orders_by_row = self.order_info_by_row("support/online_orders.csv")

      all_online_orders_by_row.each do |online_order|
        order = OnlineOrder.new(online_order[0].to_i,online_order[1], Grocery::Customer.find(online_order[2].to_i),online_order[3].to_sym)

        all_online_orders << order
      end

      return all_online_orders

    end #end self.all

    def total

      if @products.count >0
        @total = super + 10
      else
        @total = super
      end
      # raise ArgumentError.new("This order has no products.")
    end

    def add_product(product_name, product_price)
      if @status == :pending || @status == :paid
        return super
      end

      return false
    end

    # def self.find(id)
    #   super
    # end

    def self.find_by_customer(customer_id)
      customers_orders = []
      self.all.each {|online_order| customers_orders << online_order if online_order.customer.id == customer_id}

      raise ArgumentError.new "Sorry, we don't have an order matching that customer ID number." if customers_orders.empty?

      return customers_orders
    end

    def self.order_info_by_row(csv_file)
      super(csv_file="support/online_orders.csv")
    end



  end #Online Order class

end #end Grocery module

# binding.pry




############GRAVEYARD FOR PREVIOUS APPROACHES BELOW,  RIP & THANK YOU ######


# def self.all(csv_file = "support/online_orders.csv" ) # should I define a method that creates a hash/array of all object information? Self.all would then iterate through the array of object information, create the Object instance as relevant, and return an array of all the newly created objects
  # super(csv_file = "support/online_orders.csv")

# end
    #
    # def initialize(id,products,customer,status= :pending)
    #   @id = id
    #   @products = products
    #   @customer = customer #return customer by customer id?
    #   @status = status
    #   @total = 0
    # end #end initialize


    # def self.all(csv_file = "support/online_orders.csv" ) # should I define a method that creates a hash/array of all object information? Self.all would then iterate through the array of object information, create the Object instance as relevant, and return an array of all the newly created objects

      # all_online_orders = []
      # csv_file = "support/online_orders.csv"
      #
      # CSV.open(csv_file, "r").each do |row|
      #   id = row[0].to_i
      #   product_info = row[1].gsub(":", ",").gsub(";", ",").split(",")
      #   customer_id = row[-2].to_i
      #   status = row[-1].to_sym #check to see if all online_orders have a status, must be one of the four valid statuses
      #
      #   online_order_products = {}
      #   idx = 0
      #
      #   while idx < product_info.length
      #     online_order_products[product_info[idx]] = product_info[idx + 1].to_f
      #     idx += 2
      #   end
      #
      #   order = OnlineOrder.new(id, online_order_products,Grocery::Customer.find(customer_id),status)
      #   all_online_orders << order
      #
      # end
      #
      # return all_online_orders


    # end #end self.all
