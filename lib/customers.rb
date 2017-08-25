require 'csv'

module Grocery
  class Customer
    attr_reader :id, :email, :address

    def initialize(id, email, address)
      @id = id
      @email = email
      @address = address
    end

    def self.all
      all = []
      customers = []
      CSV.open("../support/customers.csv", "r", converters: :numeric).each do |row|
        id = row[0]
        email = row[1]
        address = row[2..-1].join(", ")
        customers_info = [id, email, address]
        customers << customers_info
        end
        all << customers

      all_instances = []
      all[0].each do |id, email, address|
        customer_instance = Customer.new(id, email, address)
        all_instances << customer_instance
      end

      return all_instances
    end

    def self.find(id)
      all
      if id > 0 && id <= all.length
        return all[id - 1]
      else
        return "Sorry, that customer doesn't exist"
      end
    end

  end
end

p Grocery::Customer.all.class
p Grocery::Customer.all[4].class
p Grocery::Customer.find(36).class
