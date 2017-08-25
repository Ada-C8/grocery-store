require 'pry'
require 'csv'
module  Grocery
  class Customer
    attr_reader :customer_id, :email, :address

    @@all_customers = []

    def initialize(customer_id, email, address)
      @customer_id = customer_id
      @email = email
      @address = address
    end

    @@all_customers = []

    def self.all
      if @@all_customers.length > 0
        return @@all_customers
      end
      CSV.open("support/customers.csv", "r").each do |line|
        customer_id = line[0].to_i
        email = line[1]
        address = {address1: line[2], city: line[3], state: line[4], zip_code: line[5] }
        @@all_customers << self.new(customer_id, email, address)
      end
      return @@all_customers
    end

    def self.find(id_input)
      counter = 0
      Customer.all.each do |customer|
        if customer.customer_id == id_input
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
