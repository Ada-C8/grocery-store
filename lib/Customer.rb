require 'csv'
require 'pry'

module Grocery
class Customer
  attr_reader :id, :email, :address

  def initialize(id, email, address)
    @id = id
    @email = email
    @address = address
  end

  def self.all

    customers = []
    CSV.open("support/customers.csv", 'r').each do |line|
      total = line.length
      id = line[0].to_i
      email = line[1]
      address_array = line[2..total]
      address_array.join
      address = address_array
      customers << self.new(id, email, address)
    end
    return customers
  end
end
#     customers_array = []
#     customers = CSV.open("../support/customers.csv", 'r')#.each do |line|
#       # customer_array = line.join
#       # customer_array = line.split(",")
#
#         #customer_array.each do |id_email_address|
#         customers.each do |id_email_address_to_hash|
#
#           customer_hash = {}
#           customer_hash[:id] = customers_array[0]
#           customer_hash[:email] = customers_array[1]
#           customer_hash[:address] = customers_array[2]
#
#           customers_array << customer_hash
#         end
#     #end
#
#     return customers_array
#   end
#
#   def self.find
#   end
#
#
end
