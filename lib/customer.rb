require 'csv'

class Customer

  attr_reader :customer_id, :email, :address

  def initialize(customer_id, email, address)
    @customer_id = customer_id
    @email = email
    @address = address
  end

  def self.all
    #csv_array_of_all_orders = []
    #1: Read the csv file
    #cvs line = id_number, email, housenumber street,town, state, zipcode
    #make into [(id_number, email, (address))]
    all_customers = []
    CSV.open("support/customers.csv", 'r').each do |line|
      one_customer =[]
      customer_id = line[0]
      email = line[1]
      address = line[2..5]
      one_customer << customer_id << email << address
      all_customers << one_customer
    end
    return all_customers
  end
end #end of customer class

# customer_id = 13
# email = "bert@yahoo.com"
# address = "12 Caldwell Ln, Nashvegas, TN 43254"
# person = Customer.new(customer_id, email, address)
# puts person.address
