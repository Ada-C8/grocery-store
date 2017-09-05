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
      all_customers = []
      CSV.open("support/customers.csv", 'r').each do |line|
        id = line[0].to_i
        email = line[1]
        address = line.drop(2).join(" ")
        customer = Grocery::Customer.new(id, email, address)
        all_customers << customer
      end
      return all_customers
    end

    def self.find(customer_id)
      found_cust = nil
      self.all.each do |customer|
        if customer.id == customer_id
          found_cust = customer
          return found_cust
        end
      end
      raise ArgumentError.new("Order does not exist!") if found_cust == nil
    end # DEF

  end # CUSTOMER CLASS
end # MODULE
