require 'csv'
module Grocery
  class Customer
    attr_reader :id, :email, :address_info
    def initialize(input_id, input_email, input_address_info)
      @id = input_id
      @email = input_email
      @address_info = input_address_info
    end
    def self.all
      all_customers =[]
      CSV.read('../support/customers.csv').each do |row|
        customer_id = row[0]
        customer_email = row[1]
        customer_address = {
          address1: row[2],
          city: row[3],
          state: row[4],
          zip: row[5]
        }
        all_customers.push(Grocery::Customer.new(customer_id, customer_email, customer_address))
      end # => end of csv
      return all_customers
    end # => end of self.all
    # def self.all
    #   all_orders =[]
    #   CSV.read('../support/orders.csv').each do |row|
    #     id = row[0]
    #     products_hash = {}
    #     product_row = row[1].split(";")
    #     product_row.each do |pair|
    #       pairs = pair.split(":")
    #       products_hash[pairs[0]] = pairs[1]
    #     end # end of product_row
    #     all_orders.push(Grocery::Order.new(id, products_hash))
    #   end #end of csv
    #   return all_orders
    # end # end of load_data
    def self.find(input_id)
    end
  end
end
