require 'csv'

module Grocery
  class Customer
    attr_reader :id, :email_address, :delivery_address

    def initialize(id, email_address, delivery_address)
      @id = id
      @email_address = email_address
      @delivery_address = delivery_address
    end

    def self.all
      customers_info = []
      CSV.open("./support/customers.csv", "r").each do |line|
        id = line[0].to_i
        email_address = line[1]
        delivery_address =  line[2] + ", " + line[3] + ", " + line[4] + "" + line[5]

        customers_info << Grocery::Customer.new(id, email_address, delivery_address)
      end
      return customers_info
    end

    def self.find(id)
      # returns an instance of Customer where the value of the id field in the CSV matches the passed parameter
      found_customer = nil
      customers = self.all
      customers.each do |customer|
        if customer.id == id
          return found_customer = customer
        end
      end
      raise ArgumentError.new("Customer does not exist")
    end
  end
end






#######################
# testing
# customer_info = []
# CSV.open("../support/customers.csv", "r").each do |line|
#   id = line[0].to_i #variable stores all the numbers, object of all id numbers?
#   # puts id
#   # print line
#   email_address = line[1]
#   # puts email_address
#
# delivery_address =  line[2] + ", " + line[3] + ", " + line[4] + "" + line[5]
#
# customer_info.push(id, email_address, delivery_address)
# # puts delivery_address
# end
#
# puts customer_info
 #  d = a + ", " + b + " " + c
 # => "71596 Eden Route, Connellymouth LA"
