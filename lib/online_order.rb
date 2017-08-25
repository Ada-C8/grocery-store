require 'csv'
require_relative 'order'

module Grocery
  class OnlineOrder < Order
    attr_reader :customer_id, :status
    def initialize(id, products, customer_id, status)
      super(id, products)
      @customer_id = customer_id
      @status = status.to_sym
    end #initialize

    # def customer(customer_id)
    #   # Customer.find
    # end

    def total
      if super == 0
        return 0
      else
        super + 10
      end
    end

    def add_product
      super
    end #add_product

    def self.all
      # not using super b/c new csv and taking in more arguments (we don't want anything from Order.all from Order file) we want ALL of the online_orders
    end #self.all

    def self.find(id)
      super
    end #self.find(id)

  end # Customer class
end # Grocery module
