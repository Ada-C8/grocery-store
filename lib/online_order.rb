module Grocery
  require 'csv'
  require_relative 'order'
  require_relative 'customer'

  class OnlineOrder < Grocery::Order
    attr_reader :customer, :status

    def initialize(id, products, customer, status=:pending)
      super(id, products)
      @customer = customer
      @status = status
    end

    def total
      if @products.length == 0
        return super
      # elsif @status == pending || @status == paid
      else
        return super + 10
      end
    end

    def self.all
    end

    def self.find(id)
    end

    def self.find_by_customer(customer_id)
    end
  end # end of class
end # end of module
