# require 'customer_spec'
require 'CSV'
module Grocery
  class Customer
    #Customer attributes: ID, email, address
    attr_reader :id, :email, :address, :city, :state, :zip

    def initialize(id, email, address, city, state, zip)
      @id = id
      @email = email
      @address = address
      @city = city
      @state = state
      @zip = zip
    end

    def self.all
      @@customers = []
      @@line_count = 0
      # returns a collection of Customer instnces, representing all Customers in CSV
      CSV.open("support/customers.csv", 'r').each do |line|
        id = line[0]
        email = line[1]
        address = line[2]
        city = line[3]
        state = line[4]
        zip = line[5]
        @@customers << Customer.new(id, email, address, city, state, zip)
        @@line_count +=1
      end
      return @@customers
    end

    def self.line_count
      return @@line_count
    end

    def self.customers
      return @@customers
    end

    def self.find(id)
      @@customers.each do |customer|
        if customer.id.to_i == id
          return customer
        end
      end
    raise ArgumentError.new "This customer does not exist"
    end
  end
end
