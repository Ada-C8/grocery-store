require 'csv'
require_relative 'order'

module Grocery
  class OnlineOrder < Order
    attr_reader :status, :customer

    def initialize (status, customer)
      super
      @status = :status
      @customer = customer
    end

    #
    # def total
    #
    # end
    #
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
