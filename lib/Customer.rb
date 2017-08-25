require 'csv'
require 'pry'

module Grocery
  class Customer
    attr_reader :id, :email, :address

    def initialize(id, email, address)
      @id = id
      @email = email
      @address = address
    end

    def self.all

      customers = []
      CSV.open("support/customers.csv", 'r').each do |line|
        total = line.length
        id = line[0].to_i
        email = line[1]
        address_array = line[2..total]
        address_array.join
        address = address_array
        customers << self.new(id, email, address)
      end
      return customers
    end

    def self.find(val)
      customers = Customer.all

      found_customer = nil
      customers.each do |customer|
        if customer.id == val
          found_customer = customer
        end
      end
      if found_customer == nil
        raise ArgumentError.new("Invalid order #{val}")
      else
        return found_customer
      end
    end
  end

end
