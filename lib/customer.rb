require 'csv'
#require_relative 'order.rb'
module Grocery

  class Customer < Order
    attr_reader :id, :email, :address

    def initialize(id, email, address)
      @id = id
      @email = email
      @address = address
    end

  end
end



# puts Customer.ancestors  #temp, checks its inheritance
#
#     #CSV must be in an array
#     #in order to test using rake, only one period (instead of two) is needed
#     def self.all
#       array = []
#       CSV.open('../support/customers.csv', 'r').each do |line|    ##
#         @id = line.shift.to_i
#         @email = line.shift
#         @delivery_info = line
#         return "#{@id}, #{@email}, #{@delivery_info}"
#       end
#       #returns object memory address
#       return "#{@id}, #{@email}, #{@delivery_info}"
#       #returns all customer info from new CSV
#
#       #if I don't put anything here
#       #it should automatically be inherited
#       #if I add something, super first
#       #CSV specs need to be adjusted
#     end
#
#     def self.find(id)
#       #returns instance of customer found
#       #by customer id
#       #shouldn't need to change if CSV has
#       #already been changed
#     end
#   end
# end
#
# orders = Grocery::Order::Customer.self.all
# print orders
