require 'csv'
require_relative 'order.rb'

module Grocery
  class Customer
    attr_reader :id, :email, :address

    def initialize(id, email, address)
      @id = id
      @email = email
      @address = address
    end

    def self.all
      all_customers = []
      CSV.open("/Users/kimberley/ada/week-three/grocery-store/support/customers.csv", "r").each do |line|
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

    def self.find(id)
      if id.to_i > self.all.count || id.to_i < 1
        raise ArgumentError.new ("That customer ID does not exist.")
      end
      index = id.to_i - 1
      return Grocery::Customer.all[index]
    end

  end #end of class
end #end of module
