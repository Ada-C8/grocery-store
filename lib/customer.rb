require 'csv'

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
        id = line[0].to_i
        email = line[1]
        address= {
          address1: line[2],
          city: line[3],
          state: line[4],
          zipcode: line[5]
        }
        customers << self.new(id, email, address)

      end
      return customers
    end
  end
end
