require_relative "order.rb"

class OnlineOrder < Grocery::Order
attr_reader :order, :customer, :status

def initialize(order, customer, status: "pending")
  @order = order
  @customer = customer
  @status = :status

end


def total
  return super + 10
end

def add_product

  ## if status is pending or paid
  return super
  ## else raise ArgumentError
end

end
