require_relative 'order.rb'
require_relative 'customer.rb'
require 'awesome_print'

#The OnlineOrder is a subclass of Order.  It also includes the status of the order and a customer id.

module Grocery
  class OnlineOrder < Grocery::Order

    attr_reader :id, :customer, :status, :products

    # id and customer id are integers, products a hash, customer and instance of Customer, and status a symbol
    def initialize(id, products, customer_id, status)
      super(id, products)
      @customer = get_customer(customer_id)
      @status = status
    end

    # Uses the CSV to create an instance of an order
    def self.create_order(purchase_array)
      order_id = purchase_array[0].to_i
      customer_id = purchase_array[2].to_i
      status  = purchase_array[3].to_sym
      products = {}
      purchase_array[1].split(";").each do |product|
        product_with_price = product.split(":")
        products[product_with_price[0]] = product_with_price[1].to_f
      end

      order = Grocery::OnlineOrder.new(order_id, products, customer_id, status)
      return order
    end


    # Input: CSV file of online_orders. Output: An array of Order instances
    def self.all(csv_file)
      online_orders = Array.new
      CSV.read(csv_file).each do |purchase_array|
        order = self.create_order(purchase_array)
        online_orders << order
      end
      return online_orders
    end

    # Returns an order based on the id
    def self.find_id(id, csv_file )
      CSV.read(csv_file).each do |purchase_array|
        if purchase_array[0].to_i == id.to_i
          order = self.create_order(purchase_array)
        return order
        end
      end
      raise ArgumentError.new "This order doesn't exist"
    end

    #Returns an array of customer Orders based on customer id
    def self.find_by_customer(customer_id, csv_file)
      customer_orders = []
      self.all(csv_file).each do |order|
        if order.customer.id == customer_id
          customer_orders << order
        end
      end
      if customer_orders.length != 0
        return customer_orders
      end
      raise ArgumentError.new "This customer doesn't exist"
    end

    #Returns an instance of Customer based on customer id (Used in initialize method)
    def get_customer(customer_id)
      return Grocery::Customer.find(customer_id, './support/customers.csv')
    end


    def total
      total = super
      total == 0 ? 0 : total += 10
    end

    # def total
    #   total = super
    #   if total == 0
    #     return 0
    #   else
    #     total += 10
    #   end
    #   return total
    # end

    def add_product(product, price)
      if @status == :pending || @status == :paid
        super(product, price)
      else
        raise ArgumentError.new "current status not available to add_product"
      end
    end

  end
end







#
# order = Grocery::OnlineOrder.find_id(5, './support/online_orders.csv')
#
# ap order

# ap Grocery::OnlineOrder.find_by_customer(20, './support/online_orders.csv')
#
# orders = Grocery::OnlineOrder.all('./support/online_orders.csv')
#
# p Grocery::OnlineOrder.find_id(15,'./support/online_orders.csv')



# online_order = Grocery::OnlineOrder.new(10, {"Jerusalem Artichoke" => 59.92}, 26, "complete")

# p online_order.customer.class
