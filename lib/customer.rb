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

   def self.find(id)
     all_customers = Grocery::Customer.all
     all_customers.each do |element|
         if element.id == id
           return Customer.new(element.id, element.email, element.address)
         end
     end
     raise ArgumentError.new("Id does not exist.")
   end

   end
end
