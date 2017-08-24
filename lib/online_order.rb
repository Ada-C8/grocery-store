require_relative './order.rb'

class OnlineOrder < Grocery::Order
  attr_reader :customer
  attr_accessor :status

  def initialize(customer_id, order_status = :pending, products = nil)
    @customer = customer_id
    @products = products
    @status = order_status
  end

  def total
    return @products == nil ? 0 : super + 10
  end
end
