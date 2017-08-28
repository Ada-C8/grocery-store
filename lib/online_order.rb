module Grocery
  require 'csv'
  require_relative 'order'
  require_relative 'customer'

  class OnlineOrder < Grocery::Order
    attr_reader :customer
    
    def initialize(id, products, customer)
      super(id, products)
      @customer = customer
    end
  end # end of class
end # end of module
