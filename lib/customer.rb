require 'pry'
require 'csv'
module  Grocery
  class Customer
    attr_reader :id, :email, :address

    def initialize(id, email, address)
      @id = id
      @email = email
      @address = address

    end

    def self.all
      # return orders = [1]
      # returns a collection of Customer instances, representing all of the Customer described in the CSV. See below for the CSV file specifications
      CSV.open("support/customers.csv", "r").each do |line|
        id = line[0].to_i
        email = line[1]
        address = {address1: line[2], city: line[3], state: line[4], zip_code: line[5] }
        array = [id, email, address]
        return array
      end
    end

    def self.find(id)
      # self.find(id) - returns an instance of Customer where the value of the id field in the CSV matches the passed parameter
    end

  end
end
