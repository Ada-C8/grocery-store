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
      CSV.open("../support/customers.csv", "r", converters: :numeric).each do |row|
        id = row[0]
        email = row[1]
        address = row[2..-1].join(", ")
        all_customers << Customer.new(id, email, address)
      end
      return all_customers
    end

    def self.find(id)
      all
      if id > 0 && id <= all.length
        return all[id - 1]
      else
        raise ArgumentError.new("That customer doesn't exist")
      end
    end

  end
end
