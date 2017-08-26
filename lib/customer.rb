require 'csv'
module Grocery
  class Customer

    attr_reader :customer_id, :email, :address

    def initialize(customer_id, email, address)
      @customer_id = customer_id
      @email = email
      @address = address
    end


    def self.all
      #csv line format =
      #id_number,email,housenumber street,town,state,zipcode
      #Goal = ([(id_number, email, (address))], ... )
      #1. Open file and extract id_number, email and address
      cust_info_arr = []
      CSV.open("support/customers.csv", 'r').each do |line|
        one_customer =[]
        customer_id = line[0]
        email = line[1]
        address = line[2..5]
        #2. put information for a single customer into a array
        one_customer << customer_id << email << address
        #3. put information for all customers into a array
        cust_info_arr << one_customer
      end

      all_customers = []
     #4. make new instances of Customer for each object in array in 3
      cust_info_arr.each do |single_cust_info|
        new_customer = Customer.new(single_cust_info[0], single_cust_info[1], single_cust_info[2])
        all_customers << new_customer
      end
      #5. return an array of all customers
      return all_customers
    end

    #returns an instance of Customer where the value of the id field in the CSV matches the passed parameter.
    def self.find(customer_id)
      collection_of_customers = Customer.all
      collection_of_customers.each do |customer|
        if customer.customer_id == customer_id.to_s
          return customer
        end
      end
      raise ArgumentError.new("Customer number #{customer_id} could not be found.")
    end
  end #end of customer class
end
