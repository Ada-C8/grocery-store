require_relative "order.rb"

module Grocery
  class Customer

    attr_reader :id, :email, :address

    def initialize(id, email, address)
      @id = id
      @email = email
      @address = address
    end

    # reads csv, stores elements in customer object, returns array of customer objects
    def self.all
      customers = []
      CSV.open("support/customers.csv", "r").each do |line|
        customers << Grocery::Customer.new(line[0].to_i, line[1], line[2..5].join(", ") )
      end
      return customers
    end

    # finds Customer instance based on id
    def self.find(id)
      customers = Grocery::Customer.all
      if id > customers.length || id <= 0
        raise ArgumentError.new('Invalid ID.')
      else
        return customers[id-1]
      end
    end

  end
end
