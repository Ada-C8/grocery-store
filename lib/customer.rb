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

    end

    def self.find(id)
      # self.find(id) - returns an instance of Customer where the value of the id field in the CSV matches the passed parameter
    end

  end
end
