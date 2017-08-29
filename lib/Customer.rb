require 'csv'

module Grocery
  class Customer
    attr_reader :id, :email, :address

    # method to creat each instance of Customer
    def initialize(id, email, address)
      @id = id
      @email = email
      @address = address
    end # initialize

    # Class method that calls on itself.
    def self.all
      array_Customers = []

      CSV.open("support/customers.csv").each do |customer_row|

        # take each customer row and then split at the comma into separate fields, store them.
        # variables for id and email.
        # #hash for address' parts (street address, city, state, and zip)
        # turn this info into an instance Customer
        # store each instance into an array.

        customer_id = customer_row[0].to_i
        email = customer_row[1]

        # create hash for address info
        street_address = customer_row[2]
        city = customer_row[3]
        state = customer_row[4]
        zip = customer_row[5]
        # hash for address info
        address = {
          street_address: street_address,
          city: city,
          state: state,
          zip: zip
        }

        array_Customers << self.new(customer_id, email, address)

      end # end each loop
      return array_Customers
    end # end self.all

    def self.find(id)
      # first, we need to access all the Customer objects to find attributes. Loop
      # second, we need to get inside the object.
      # third, we need to match the input order attribute with csv info
      self.all.each do |customer_object|
        if id == customer_object.id
          return customer_object

        end
      end
      raise ArgumentError.new("Invalid customer id - order does not exist")
    end
  end # class
end # module

# binding.pry

# puts Grocery::Customer.find(25).inspect
