require 'csv'
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
     CSV.read('./support/customers.csv').each do |row|
       id = row.delete_at(0).to_i
       email = row.delete_at(0)
       address_string = row.join(" ")
       address_array = address_string.split(',')
       address_string = address_array.join(" ")
       address = address_string
       customers << self.new(id, email, address)
     end
     return customers
   end










   end
end
