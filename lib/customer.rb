require 'csv'


module Grocery
  class Customer
    attr_reader :delivery_address

    @@all_customers = []

    def initialize(customer_id, email, street_address, city, state, zipcode)
      @customer_id = customer_id
      @email = email
      @street_address = street_address
      @city = city
      @state = state
      @zipcode = zipcode
      @delivery_address = "#{@street_address}, #{@city}, #{@state}, #{@zipcode}"
    end #initialize

    def self.all
      #returns a collection of Customer instances, representing all of the Customer described in the CSV. See below for the CSV file specifications

      @@all_customers = []

      CSV.open("support/customers.csv", 'r').each do |line|
        customer_id = line[0]
        email = line[1]
        street_address = line[2]
        city = line[3]
        state = line[4]
        zipcode = line[5]

        @@all_customers << Grocery::Customer.new(customer_id, email, street_address, city, state, zipcode)
      end #.open

      return @@all_customers
    end #self.all


  end #Customer
end #Grocery


# def self.all
#   #method that will return an array of all the orders
#   #the numnber of orders in the array is correct,
#   @@all_orders = []
#   CSV.open("support/orders.csv", 'r').each do |line|
#     id = line[0]
#     order_products = {}
#     products = line[1].split(';')
#
#     products.each do |item_price|
#       product_price = item_price.split(':')
#       order_products[product_price[0]] = product_price[1].to_f
#     end #.each
#
#     products = order_products
#     @@all_orders << Grocery::Order.new(id, products)
#   end #open
#
#   return @@all_orders
# end #all

#1,leonard.rogahn@hagenes.org,71596 Eden Route,Connellymouth,LA,98872-9105
