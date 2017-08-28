require 'csv'

module Grocery
  class Customer
    attr_reader :customer_id, :email, :address, :city, :state, :zip

    def initialize(customer_id, email, address, city, state, zip)
      @customer_id = customer_id
      @email = email
      @address = address
      @city = city
      @state = state
      @zip = zip
    end

    def self.all
      @all_customers = []

      CSV.read("./support/customers.csv").each do |row|
        customer_id = row[0].to_i
        email = row[1].to_s
        address = row[2].to_s
        city = row[3].to_s
        state = row[4].to_s
        zip = row[5].to_s

        customer = Customer.new(customer_id, email, address, city, state, zip)
        @all_customers << customer
      end
      return @all_customers
    end

    def self.find(customer_id)
      customers = Grocery::Customer.all

        customers.each do |customer|
          if customer.customer_id == customer_id
            return customer
          end
        end

        raise ArgumentError.new "Customer does not exist"
    end

  end #end of class

end #end of module
