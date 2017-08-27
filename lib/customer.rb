# customer
require 'csv'
require 'awesome_print'


module Grocery
  class Customer
    attr_reader :id, :email, :delivery_address
    def initialize(id, email, delivery_address)
      @id = id
      @email = email
      @delivery_address = delivery_address
    end #initialize end


    # in this method I am creating a new instance of the customer for each row in the csv (in the loop) and pushing those new instances of customer to the @customers array.

    # loop is going through each row in the csv (customer_attributes) and passing the id, email, and address as the instance variables (note each piece of the address that was divided by the comma in the CSV has been joined).

    def self.all
      @customers = []
      CSV.open('/Users/Marisa/documents/ada developers academy/projects/grocery-store/support/customers.csv', 'r').each do |customer_attributes|
        customer = Grocery::Customer.new(
        customer_attributes[0].to_i,
        customer_attributes[1],
        customer_attributes[2..5].join(",")
        )
        @customers << customer
      end
      # ap @customers
      return @customers
    end #self.all method end



    def self.find(id)
      @customers.each do |customer|
        if (id == customer.id)
          return customer
        end
      end
      raise ArgumentError.new("You messed up!")
    end #self.find method end


  end #class end
end #module end

Grocery::Customer.all
