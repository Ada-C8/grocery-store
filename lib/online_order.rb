require 'csv'
require_relative 'order'
require_relative 'customer'

module Grocery
  class OnlineOrder < Order
    attr_reader :status, :customer

    def initialize(status, customer)
      super
      @status = :pending
      @customer = customer  #Customer.new
    end


    # def total
    #
    # end

    # def add_product
    #end

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
