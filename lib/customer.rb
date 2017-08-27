require 'csv'

#Customer class within Grocery module
module Grocery
  class Customer
    attr_reader :id, :email, :address

    def initialize(id, email, address)
      @id = id
      @email = email
      @address = address
    end#initialize

    #self.all returns a collection of Customer instances, representing all of the customers described in the CSV
    def self.all
      id = nil
      email = nil
      address = nil
      all_customers = []

      CSV.open('support/customers.csv', 'r').each do |line|
        id = line[0].to_i
        email = line[1]
        # address = line[2] + " " + line[3] + " " + line[4] + " " + line[5]
        address = line[2..5].join(", ")

      customer = Customer.new(id, email, address)
      all_customers << customer
      end

      return all_customers
    end#self.all

    # self.find(id) returns an instance of Customer where the value of the id field in the CSV matches the passed parameter
    def self.find(id)
      customers_arr = Customer.all

      all_ids = []
      customers_arr.each do |customer|
        all_ids << customer.id
      end

      unless all_ids.include? (id)
        raise ArgumentError.new("Invalid customer id: #{id}")
      end

      return customers_arr[id-1]
    end
  end#Customer
end

# hello = Grocery::Customer.all[0].address
# puts hello
