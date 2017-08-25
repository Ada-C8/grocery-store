require_relative "order.rb"
require_relative "customer.rb"

class OnlineOrder < Grocery::Order
attr_reader :order, :customer, :status

def initialize(customer, status: "pending")
  # @order = order
  @customer = customer
  @status = status.to_sym
end


def total
  return super + 10
end

def add_product

  ## if status is pending or paid
  return super
  ## else raise ArgumentError
end

def self.all(file)
  # file = CSV.open("support/online_orders.csv", "r")
  return super

end
end

# test = OnlineOrder.new("customer")
# puts test.status
#
# test = OnlineOrder.new("customer", status: "not pending")
# puts test.status
 puts OnlineOrder.all('support/online_orders.csv')[0].products

# puts OnlineOrder("customer").total
