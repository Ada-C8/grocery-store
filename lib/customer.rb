require_relative 'order.rb'
require 'awesome_print'

class Grocery::Customer
  attr_reader :id, :email, :delivery_address

  def initialize(id, email, delivery_address)
    @id = id
    @email = email
    @delivery_address = delivery_address
  end

  def self.all(csv_file)
    # returns a collection of Customer instances, representing all of the Customer described in the CSV. See below for the CSV file specifications
    customers = []
    CSV.read(csv_file).each do |customer_info|
      id = customer_info[0]
      email = customer_info[1]
      delivery_address = {
      address: customer_info[2],
      city: customer_info[3],
      state: customer_info[4],
      zip_code: customer_info[5],
      }

      customers << Grocery::Customer.new(id, email, delivery_address)
    end

    return customers

  end

  def self.find(id)
    # returns an instance of Customer where the value of the id field in the CSV matches the passed parameter.

  end

end

#
# customers = Grocery::Customer.all('./support/customers.csv')
#
# ap customers
