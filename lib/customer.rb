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
    end #end initialize

    def self.all
      all_customers = []

      CSV.open("support/customers.csv", "r").each do |row|
        #1st, create a hash of the products of each order
        #2nd, create a new Order object, with the id and newly created products hash
        id = row[0].to_i
        email = row[1]
        address = row[2..-1].join(", ")

        customer= Customer.new(id,email,address)
        all_customers << customer

      end

      return all_customers


    end #end self.all


    def self.find(id)
      self.all.each {|customer| return customer if customer.id == id}
      raise ArgumentError.new "Sorry, we don't have a customer matching that ID number."

    end #end self.fin

  end #end Customer class



end #end Grocery module?
