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
  end # end of class
end # end of module
