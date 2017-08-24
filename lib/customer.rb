require 'csv'


module Grocery
  class Customer
    attr_reader :delivery_address, :customer_id, :email

    @@all_customers = []

    def initialize(customer_id, email, street_address, city, state, zipcode)
      @customer_id = customer_id
      @email = email
      @street_address = street_address
      @city = city
      @state = state
      @zipcode = zipcode
      @delivery_address = "#{@street_address}, #{@city}, #{@state}, #{@zipcode}"
    end #initialize

    def self.all
      #returns a collection of Customer instances, representing all of the Customer described in the CSV. See below for the CSV file specifications

      @@all_customers = []

      CSV.open("support/customers.csv", 'r').each do |line|
        customer_id = line[0]
        email = line[1]
        street_address = line[2]
        city = line[3]
        state = line[4]
        zipcode = line[5]

        @@all_customers << Grocery::Customer.new(customer_id, email, street_address, city, state, zipcode)
      end #.open

      return @@all_customers
    end #self.all

    def self.find(customer_id_to_test)
      #  returns an instance of Customer where the value of the id field in the CSV matches the passed parameter.
      # print @@all_customers

      x = self.all

      if customer_id_to_test.to_i > x.length
        raise ArgumentError.new("Error: The customer id #{id_to_test} does not exsist!")
      else
        @@all_customers.each do |instance|
          if instance.customer_id == customer_id_to_test
            return instance
          end #if
        end #.each
      end #if/else

    end #self.find


  end #Customer
end #Grocery

# Grocery::Customer.all
# Grocery::Customer.find("1")




  #1,leonard.rogahn@hagenes.org,71596 Eden Route,Connellymouth,LA,98872-9105
