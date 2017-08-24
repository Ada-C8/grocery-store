require 'csv'
require_relative 'order'
require_relative 'customer'

module Grocery
  class OnlineOrder < Order
    attr_reader :id, :products, :customer, :status
    def initialize(id, products, customer, status = :pending) #customer needs to be passed in as a customer object
      @id = id
      @products = products
      @customer = customer
      @status = status
    end

    def total
      if @products.empty?
        return 0
      end
      super + 10
    end
  end
end
