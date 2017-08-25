require 'pry'
require 'csv'
module  Grocery
  class Customer
    attr_reader :id, :email, :address

    @@all_customers = []

    def initialize(id, email, address)
      @id = id
      @email = email
      @address = address

    end

    def self.all
      # return orders = [1]
      # returns a collection of Customer instances, representing all of the Customer described in the CSV. See below for the CSV file specifications
      customers = []
      CSV.open("support/customers.csv", "r").each do |line|
        id = line[0].to_i
        email = line[1]
        address = {address1: line[2], city: line[3], state: line[4], zip_code: line[5] }
        customers << self.new(id, email, address)
      end
      return customers
    end

    def self.find(id_input)
      counter = 0
      Customer.all.each do |customer|
        if customer.id == id_input
          counter += 1
          return customer
        end
      end
      if counter == 0
        raise ArgumentError.new("Invalid Customer ID")
      end
    end
  end
end
