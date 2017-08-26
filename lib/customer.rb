require 'csv'
# NO NEED FOR  ANY require_relative
module Grocery

  class Customer
    attr_reader :id, :email, :address

    def initialize(id, email, address)
      @id = id
      @email = email
      @address = address
    end

    #CSV must be in an array
    #in order to test using rake, only one period (instead of two) is needed
    def self.all
      cust_array = []
      CSV.open('../support/customers.csv', 'r').each do |line|    ##
        id = line.shift.to_i
        email = line.shift
        address = line
        # hash = {}
        # hash[:id] = @cust_id
        # hash[:email] = @email
        # hash[:address] = @address
        cust_array << Grocery::Customer.new(id, email, address)
      end
      #returns object memory address
      return cust_array
    end

    def self.find(id)
      #returns instance of customer found
      #by customer cust_id
      #shouldn't need to change if CSV has
      #already been changed
    end

  end
end
