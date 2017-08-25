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
    cust_info_arr = []
    CSV.open("support/customers.csv", 'r').each do |line|
      one_customer =[]
      customer_id = line[0]
      email = line[1]
      address = line[2..5]
      one_customer << customer_id << email << address
      cust_info_arr << one_customer
    end
    customers = []

    cust_info_arr.each do |single_cust_info|
      customers << Customer.new(single_cust_info[0], single_cust_info[1], single_cust_info[2])
    end
    return customers
  end
end #end of customer class

# all_customers = Customer.all
# puts all_customers.class
# puts all_customers[0].class
# customer_id = 13
# email = "bert@yahoo.com"
# address = "12 Caldwell Ln, Nashvegas, TN 43254"
# person = Customer.new(customer_id, email, address)
# puts person.address
