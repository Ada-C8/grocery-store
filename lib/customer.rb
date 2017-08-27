require 'csv'

module Grocery
  class Customer
    attr_reader :id, :email, :address
    def initialize (id, email, address)
      @id = id
      @email = email
      @address = address
    end

    def self.all
      # returns info collected from csv
      customer_data = []
      CSV.open("support/customers.csv", "r").each do |data|
        id = data[0]
        email = data[1]
        address = data[2] + "," + data[3] + "," + data[4] + "," + data[5]# 66255 D'Amore Parkway
        instance_of_a_customer = Customer.new(id, email, address)
        customer_data << instance_of_a_customer
      end
      return customer_data
    end

    def self.find(id)
      #returns an instance of a customer where his id matches id in the csv
      all_data = Customer.all
      all_data.each do |i|
        if i.id == id
          return i
        end
      end
      throw ArgumentError.new("Couldn't find that customer, sorry :(")
    end
  end
end

# Create a Customer class within the Grocery module.
# Each new Customer should include the following attributes:
# ID
# email address
# delivery address information
# The Customer should also have the following class methods:
# self.all - returns a collection of Customer instances, representing all of the Customer described in the CSV. See below for the CSV file specifications
# self.find(id) - returns an instance of Customer where the value of the id field in the CSV matches the passed parameter.
