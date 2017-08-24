require 'csv'

module Grocery
  class Customer
    attr_reader :id, :email, :address


    def initialize(id, email, address)
      @id = id
      @email = email
      @address = address
    end # initialize

# 1,leonard.rogahn@hagenes.org,71596 Eden Route,Connellymouth,LA,98872-9105

    def self.all
      CSV.open("../support/customers.csv", 'r').each
    end # self.all

    def self.find(id)
    end # self.find
  end # Customer class
end # Grocery module
