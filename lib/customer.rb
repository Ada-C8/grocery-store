# customer.rb
# An instance of the Customer class will be used within each instance of the OnlineOrder class.

require 'csv'
require 'awesome_print'
require 'pry'

module Grocery
  class Customer

  attr_reader :id, :email, :address

  def initialize(id, email, address)
    @id = id
    @email = email
    @address = address
  end

#returns a collection of Customer instances, representing all of the Customer described in the CSV. See below for the CSV file specifications
  def self.all
    customers = []
    build_address = ""
    CSV.read('./support/customers.csv').each do |row|
      #THIS DIDN'T WORK (IS JOIN NO LONGER IN RUBY'S CURRENT VERSION?)
      #build_address = [row[2],row[3],row[4],row[5]].join(", ")
      build_address = row[2] + ", " + row[3] + ", " + row[4] + ", " + row[5]
      customers << Customer.new(row[0],row[1],build_address)
    end
    return customers
  end

# self.find(id) - returns an instance of Customer where the value of the id field in the CSV matches the passed parameter.
  def self.find(input_id)
    chosen_person = []
    customers = Grocery::Customer.all
    customers.each do |person|
      if person.id == input_id
        chosen_person = person
      end
    end
    return chosen_person
  end #end of self class method

  end #end of class
end #end of module


Grocery::Customer.all
#customer = Grocery::Customer.find("1")
#print customer.id
#print customer.email
#print customer.address
