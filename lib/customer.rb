require 'csv'
require 'pry'

require_relative 'order.rb'

module Grocery

  class Customer

    attr_reader :customer_id, :email, :address, :city, :state, :zip_code

    def initialize(customer_id, email, address, city, state, zip_code)
      @customer_id = customer_id
      @email = email
      @address = address
      @city = city
      @state = state
      @zip_code = zip_code
    end

    def self.all
      all_customers =[]
      CSV.open("support/customers.csv", 'r').each do |info_sheet|
        #sort the ugly string out
        #{id_number => {item => price}}
        # customer_id, email, address, city, state, zip_code)
        all_customers << self.new((info_sheet[0]).to_i, info_sheet[1], info_sheet[2], info_sheet[3], info_sheet[4], info_sheet[5])

      end
      all_customers
    end

    def self.find(number)
      # ound_it = (Grocery::Order.all).detect{|grocery_order| grocery_order.id == number}
      # raise ArgumentError.new("Order Not Found") if found_it == nil
      # found_it
      customer_array = Grocery::Customer.all
      found_it = customer_array.detect{|customer| customer.customer_id == number}
      raise ArgumentError.new("Order Not Found") if found_it == nil
      found_it
    end


  end
end
