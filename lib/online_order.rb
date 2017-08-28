require 'csv'

module Grocery
  class OnlineOrder < Grocery::Order
    attr_reader :customer_id, :status

    def initialize(id, products, customer_id, status = :pending)
      super(id, products)
      @customer_id = customer_id
      @status = status
    end

    def get_customer(customer_id)
      return Grocery::Customer.find(@customer_id)
    end

    def total
      super + 10
    end

  end #end of online_order

end # end of grocery
