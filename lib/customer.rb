require 'csv'
require 'pry'

require_relative '../lib/order'

module Grocery

  class Customer
    attr_reader :id, :email, :address

    def initialize(id, email_address, delivery_address)
      @id = id
      @email = email_address
      @address = delivery_address
    end

    def self.all
      all_customers = []

      CSV.open("support/customers.csv", "r").each do |row|
        id = row[0].to_i
        email = row[1]
        address = row[2..-1].join(", ") #currently, just join everything into a string. Can later keep everything separate if need be

        customer= Customer.new(id,email,address)
        all_customers << customer

      end

      return all_customers
    end


    def self.find(id)
      self.all.each {|customer| return customer if customer.id == id}
      raise ArgumentError.new "Sorry, we don't have a customer matching that ID number."

    end

  end #end Customer class



end
