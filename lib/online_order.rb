require 'csv'
require_relative 'order'
require_relative 'customer'

module Grocery
  class OnlineOrder < Order
    attr_reader :status, :customer

    def initialize(id, products, customer_id, status = :pending)
      @id = id
      @products = products
      @customer = Customer.find(customer_id)
      @status = status
      # maybe put in status options there
    end

    def total
      super + 10
    end

  end
end

#
# id = 13
# products = { "banana" => 1.99, "cracker" => 3.00 }
# customer_id = 1
# status = :pending
# new_online_order = Grocery::OnlineOrder.new(id, products, customer_id, status)
#
# puts new_online_order.customer.email
# #puts new_online_order.total
