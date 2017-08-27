require 'csv'
require_relative 'order'
require_relative 'customer'

module Grocery

class OnlineOrder < Order
  attr_reader :id, :products, :customer_id, :status
  STATUS = [:pending, :paid, :processing, :shipped, :complete]

  def initialize(id, products, customer_id, status = "pending")

    @id = id
    @products = products
    @customer_id = Grocery::Customer.find(customer_id.to_i)

    #change to sym but doesn't set default as pending
    @status = status

    #add customer object
    #add fulfillment status, stored as Symbol
    # :pending, default status == :pending
    # :paid
    # :processing
    # :shipped
    # :complete
  end

  def self.all
    #returns OnlineOrder instances
    #represents all OnlineOrders from CSV
    online_order_array = []
    CSV.open('../support/online_orders.csv', 'r').each do |line|
      id = line.shift.to_i
      products = line.shift
      customer_id = line.shift
      status = line #status is converted to symbol
      online_order_array << Grocery::OnlineOrder.new(id, products, customer_id, status)
    end
    return online_order_array
  end

  # def self.find
  #
  # end
  #
  # def self.find_by_customer(customer_id)
  # end
  #
  def total
    super
    #add $10 shipping

  end
  #
  # def add_product
  #   #QUOTE "should be updated to permit...if"
  #   #status = :pending or :paid
  #   #otherwise, raise ArgumentError
  # end

end
end #end module

all_online_orders = Grocery::OnlineOrder.all
puts all_online_orders
