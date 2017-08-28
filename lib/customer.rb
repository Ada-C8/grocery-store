module Grocery
  class Customer
    attr_reader :id, :email, :address

    def initialize(id, email, address)
      @id = id.to_i
      @email = email
      @address = address
    end

    # Returns a list of all customers from a CSV file
    def self.all
      all_customers = []
      CSV.read("support/customers.csv").each do |customer|
        # code
        id = customer[0].to_i
        email = customer[1]
        address = customer[2..5].join(", ")

        all_customers << Grocery::Customer.new(id, email, address)
      end
      return all_customers
    end

    # Takes in a customer's ID and returns the Customer object
    def self.find(id)
      self.all.each do |customer|
        return customer if customer.id == id
      end
      raise ArgumentError.new("A customer with the ID #{id} does not exist.")
    end
    
  end
end
