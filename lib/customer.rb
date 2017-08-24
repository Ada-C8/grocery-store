require 'csv'
require_relative 'order.rb'

module Grocery
  class Order
    attr_reader :id, :products

    def initialize(id, email, address)
      @id = id
      @email = email
      @address = address
    end

    # self.all - returns a collection of Customer instances, representing all of the Customer described in the CSV. See below for the CSV file specifications
    def self.all
      all_customers = []
      CSV.open("/Users/kimberley/ada/week-three/grocery-store/lib/customers.csv", "r").each do |line|

        id = line[0]
        email = line[1]
        street_address = line[2]
        city = line[3]
        state = line [4]
        zipcode = line[5]
        address = {street_address: street_address, city: city, state: state, zipcode: zipcode}

        customer = Grocery::Customer.new(id, email, address)
        all_customers << customer
      end
      return all_customers
    end
    # self.find(id) - returns an instance of Customer where the value of the id field in the CSV matches the passed parameter.
  end #end of class
end #end of module

puts Grocery::Order.all
