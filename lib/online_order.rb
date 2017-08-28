require 'csv'
require_relative 'order'
require_relative 'customer'

module Grocery

class OnlineOrder < Order
  attr_reader :id, :products, :customer_id, :status
  STATUS = [:pending, :paid, :processing, :shipped, :complete]

  def initialize(id, products, customer_id, status = "pending")
    @id = id.to_i #removed to_i here
    @products = products
    @customer_id = Grocery::Customer.find(customer_id.to_i) #removed to_i here
    #change to sym but doesn't set default as pending
    @status = status.to_sym

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
      id = line.shift # problems using .to_i
      products = {}
      produce = line.shift.split(";")
      produce.each do |items|
        two_item_array = items.split(":")
        item = two_item_array[0]
        price = two_item_array[1]
        products[item] = price
        end
      customer_id = line.shift
      status = line.join() #status should be converted to symbol in initialize
      online_order_array << Grocery::OnlineOrder.new(id, products, customer_id, status)
    end
    return online_order_array
  end

  def self.find(id)
    super
#     #all_ids = [] #not currently using
#     all_online_orders = Grocery::OnlineOrder.all
#     all_online_orders.each do |arr|
#       if arr.id == id
#         return "id: #{arr.id} #{arr.id.class},
# products: #{arr.products} #{arr.products.class},
# customer id: #{arr.customer_id} #{arr.customer_id.class},
# status: #{arr.status} #{arr.status.class}"
#         ##The following errors out and wants to remove to_i, to_sym in initialize
#         # return Grocery::OnlineOrder.new(arr.id, arr.products, arr.customer_id, arr.status)
#       end
#     end
#   #  raise ArgumentError.new("Invalid parameters for order number")
  end

  def self.find_by_customer(customer_id)
    customer_array = []
    online_orders = Grocery::OnlineOrder.all
    online_orders.each do |o_order|
      if o_order.customer_id.id == customer_id
        customer_array << o_order
      end
    end
    
    return customer_array
  end

  #
  # def total
  #   super
  #   #add $10 shipping
  #
  # end
  #
  # def add_product
  #   #QUOTE "should be updated to permit...if"
  #   #status = :pending or :paid
  #   #otherwise, raise ArgumentError
  # end

end
end #end module
