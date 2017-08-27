require 'csv'
require 'awesome_print'

# require_relative 'order' ?Is this needed?

module Grocery
  class Customer
    attr_reader :customer_id, :email, :delivery_address

    def initialize(customer_id, email, delivery_address)
      @customer_id = customer_id
      @email = email
      @delivery_address = delivery_address

      raise ArgumentError.new("customer_id must be a integer") if customer_id.class != Integer
      raise ArgumentError.new("email must be a string") if email.class != String
      raise ArgumentError.new("delivery_address must be a string") if delivery_address.class != String

    end

    def self.all
      customers = CSV.read('support/customers.csv')

      all_customers = []

      customers.each do |row|
        customer_id = row[0]
        email = row[1]

        #SHORTHAND for delivery_address:
        delivery_address = (row[2..5]).join(",")
        #LONGHAND for delivery_address:
        # delivery_address = "#{row[2]},#{row[3]},#{row[4]},#{row[5]}"

        all_customers << Customer.new(customer_id.to_i, email, delivery_address)
      end

      return all_customers
    end

    def self.find(customer_id)
      customers = Grocery::Customer.all

      customers.each do |customer_row_info|
        if customer_row_info.customer_id == customer_id
          return customer_row_info
        end
      end
      raise ArgumentError.new("CUSTOMER ##{customer_id} NOT FOUND!")
    end
  end#of_Customer_class

end#of_module

#TEST
# ap Grocery::Customer.all
#
# test_customer = Grocery::Customer.find(1)
#
# ap test_customer
