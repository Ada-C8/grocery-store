require 'csv'
require_relative 'order'

class Grocery::Customer
  attr_reader :id
  attr_accessor :email, :delivery_address

  def initialize(id, email, delivery_address)
    @id = id
    @email = email
    @delivery_address = delivery_address # an array [address, city, state, zip]
  end

  def self.all
    # returns a collection of all Customer instances from the csv
    csv = "./support/customers.csv"
    all_customers = []

    CSV.foreach(csv) do |row|
      id = row[0].to_i
      email = row[1]
      address = row[2..-1]

      customer = Grocery::Customer.new(id, email, address)
      all_customers << customer
    end

    return all_customers
  end

  def self.find(id)
    # returns the Customer instance with the given id if found; else nil
  end

  private

  def self.get_address
    # helper method that gets add
  end
end # end of Customer class

#puts Grocery::Customer.all
