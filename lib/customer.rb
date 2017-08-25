require 'csv'
require 'awesome_print'

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
      CSV.open("/Users/galeharrington/ada/week3/grocery-store/support/customers.csv", "r").each do |line|
        id = line.slice!(0).to_i
        email = line.slice!(0)
        address = line.join(", ")
        all_customers << Customer.new(id, email, address)
      end
      return all_customers
    end

    def self.find(id)
      if id.to_i > 35 || id.to_i < 1
        raise ArgumentError.new("This customer number does not exist.")
      end
      return self.all[id.to_i - 1]
    end
  end
end
