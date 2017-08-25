require 'csv'
module Grocery
  
  class Customer

    attr_reader :id, :email, :address_info

    def initialize(input_id, input_email, input_address_info)
      @id = input_id
      @email = input_email
      @address_info = input_address_info
    end

    def self.all
      all_customers =[]
      CSV.read('support/customers.csv').each do |row|
        customer_id = row[0]
        customer_email = row[1]
        customer_address = {
          address1: row[2],
          city: row[3],
          state: row[4],
          zip: row[5]
        }
        all_customers.push(Grocery::Customer.new(customer_id, customer_email, customer_address))
      end # => end of csv
      return all_customers
    end # => end of self.all

    def self.find(input_id)
      all_customers = self.all
      finder = false
      while finder == false
        all_customers.each do |unique_customer|
          if unique_customer.id == input_id
            finder = true
            return unique_customer
          end
        end # =>  end customers.each
        raise ArgumentError.new "Customer ID does not exist"
      end
    end # => end self.find
  end # => end of Customer class
end # => end of Grocery module
