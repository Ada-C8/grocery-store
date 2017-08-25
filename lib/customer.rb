require 'csv'
require 'pry'
require 'awesome_print'
# require_relative 'order.rb'

module Grocery

class Customer

  attr_reader :id, :email, :address_1, :city, :state, :zip, :all_customers

  def initialize(id, email, address_1, city, state, zip)
    @id = id
    @email = email
    @address_1 = address_1
    @city = city
    @state = state
    @zip = zip
  end


  def self.all(file_name)
    @all_customers = []
    # each_customer = {}
    CSV.open(file_name, "r").each do |row|
      @id = row[0].to_i
      @email = row[1]
      @address_1 = row[2]
      @city = row[3]
      @state = row[4]
      @zip = row[5]
      @each_customer = { id: @id, email: @email, address_1: @address_1, city: @city, zip: @zip}
      # @each_customer = row.split(",")
      @all_customers << @each_customer
    end
    return @all_customers
  end

  def self.find(file_name, id)
    self.all(file_name).each do |instance|
      if instance[:id] == id
        return instance
      end
    end
      raise ArgumentError.new "Invalid Customer Number"
  end


end

end

# all_the_customers = Grocery::Customer.all("./support/customers.csv")

customer = Grocery::Customer.find("./support/customers.csv", 1)

puts customer
