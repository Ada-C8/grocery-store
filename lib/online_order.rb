require_relative './order.rb'

class OnlineOrder < Grocery::Order
  attr_reader :customer
  attr_accessor :status

  def initialize(customer_id, order_status = :pending)
    @customer = customer_id
    @status = order_status
  end
end
