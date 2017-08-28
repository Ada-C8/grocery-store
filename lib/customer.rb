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
      return cust_array
    end

    def self.find(id)
      all_ids = []
      all_orders = Grocery::Customer.all
      all_orders.each do |arr|
        all_ids << arr.id
        if all_ids.include? id
          return Customer.new(arr.id, arr.email, arr.address)
        end
      end
      raise ArgumentError.new("Invalid parameters for customer number")
    end

  end
end

##test works
# a = Grocery::Customer.find(1)
# arr = []
# arr << a
# arr.each do |check|
#   puts check.id.class
#   puts check.email.class
#   puts check.address.class
# end
