require 'csv'

module Grocery
  class Customer
    attr_reader :customer_id, :email, :address
@@customers = []

    def initialize(customer_id, email, address)
      @customer_id = customer_id
      @email = email
      @address = address
    end # initialize

    # 1,leonard.rogahn@hagenes.org,71596 Eden Route,Connellymouth,LA,98872-9105

    def self.all
      # customers = []
      if @@customers.length > 0
        return @@customers
      end
      CSV.open("../support/customers.csv", 'r').each do |line|
        customer_id = line[0].to_i
        email = line[1]
        address = {address: line[2], city: line[3], state: line[4], zipcode: line[5]}
        @@customers << self.new(customer_id, email, address)
      end
      return @@customers
    end # self.all

    def self.find(customer_id)
      if customer_id > all.length
        raise ArgumentError.new("Error: Customer #{customer_id} does not exist")
      end

      Customer.all.each do |order|
        if order.customer_id == customer_id
          return order
        end
      end
    end # end self.find method

  end # Customer class
end # Grocery module
