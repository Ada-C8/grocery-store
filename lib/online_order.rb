require 'csv'
require_relative 'order'

module Grocery
  class OnlineOrder < Order
    attr_reader :status, :customer_id, :customer

    def initialize(id, products, customer_id, status = :pending)
      super(id, products)
      @status = status
      @customer = Grocery::Customer.find(customer_id) #Customer.new
    end

    def total
      shipping_fee = 10
      if super == 0
        return 0
      else
        return super + shipping_fee
      end
    end

    def add_product
    end

    # def self.all
    # end
    #
    # def self.find(id)
    # end
    #
    # def self.find_by_customer(customer_id)
    # end

  end #end of class
end #end of module

# customers = Grocery::Customer.all
# customer = customers[-1].id
# print customer
# online_order = Grocery::OnlineOrder.new(customer, status)
# puts online_order.customer
