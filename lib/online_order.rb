require_relative "customer"
require "csv"
require "pry"

module Grocery
  class OnlineOrder < Order
    CSVFILE = "support/online_orders.csv"

    attr_reader :id, :products, :customer_id
    attr_accessor :fulfillment_status
    def initialize(id, products, customer_id, fulfillment_status = "pending")
      super(id, products)
      @fulfillment_status = fulfillment_status
      @customer_id = customer_id.to_i
    end

    #return collection of OnlineOrder instances
    def self.all_online_order_add_arguments(id_num, hashy_hash, customer_id, fulfillment_status)
      self.new(id_num, hashy_hash,  customer_id, fulfillment_status)
    end

    #read csv file for OnlineOrder
    def self.get_csv_info
      CSV.open(CSVFILE, 'r')
    end

    def self.all
      #needs to do the same thing as Order, but change the CSV file, and get the customer id and status
      super
    end

    def add_product(product_name, product_price)
      raise ArgumentError.new("Online Order not PENDING or PAID") if @fulfillment_status != ("pending" || "paid")
      super(product_name, product_price)
    end

    #return list of OnlineOrder instance
    def self.find(id)
      super(id)
    end

    #return list of onlineorder instances
    def self.find_by_customer(number)
      found_orders = []
      order_array = Grocery::OnlineOrder.all
      order_array.each do |order|
        if order.customer_id == number
          found_orders << order
        end
      end
      raise ArgumentError.new("Order Not Found") if found_orders == nil
      found_orders
    end

    def total
      if self.products == {}
        0
      else
        super + 10
      end
    end # end of total
  end#end OnlineOrder class
end #end Grocery module
# #
