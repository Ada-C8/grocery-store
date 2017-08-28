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
      else
        return super + 10
      end
    end

    def add_product(product_name, product_price)
      unless @status == :pending || @status == :paid
        raise ArgumentError.new ("Unable to add products at this time.") #ArgumentError may not have been the appropriate exception to choose here? I was still able to pass a test with no arguments but it failed using other exceptions
      else
        return super(product_name, product_price)
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
