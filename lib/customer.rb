require 'csv'
require 'awesome_print'

module Grocery
  class Customer
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
      # returns a collection of Customer instances, representing all of the Customer described in the CSV. See below for the CSV file specifications
      customers_array = []
      ind_customer_array = []

      CSV.open("support/customers.csv", 'r').each do |line|
        ind_customer_array << line
        id = line[0].to_i
        email = line[1]
        address = line[2]
        city = line[3]
        state = line[4]
        zip = line[5]
        # delivery_address_information = line[2] + ", " + line[3] + ", " + line[4] + " " + line[5]

        customers_array << Customer.new(id, email, address, city, state, zip)
      end
      return
      # ap customers_array
    end

    def self.find(id)
      # returns an instance of Customer where the value of the id field in the CSV matches the passed parameter.
    end

  end
end

Grocery::Customer.all
