require 'csv'

module Grocery

  class Customer
    attr_reader :id, :email, :address

    def initialize(id, email, address)
      @id = id
      @email = email
      @address = address
    end # initialize

    def self.all
      customer_list = []
      CSV.read('./support/customers.csv').each do |customer|
        customer_list << Customer.new(customer[0], customer[1],  customer[2..-2])
      end
      return customer_list
    end #self.all

    def self.find(id)
      self.all.each do |customer|
       if customer.id == id
         return customer
       end
      end
      raise ArgumentError.new("No customer with id ##{id}.")
    end #self.find
  end #Customer
end #module Grocery
