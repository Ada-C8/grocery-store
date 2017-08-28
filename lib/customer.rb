require_relative 'order'

module Grocery
	class Customer
		attr_reader :id, :email, :address
		def initialize(id, email, address)
			@id = id
			@email = email
			@address = address
		end #end inititalize

		def self.all
			cust = []
			CSV.open("./support/customers.csv").each do |info|
				cust << Grocery::Customer.new(info[0].to_i, info[1], info[2..5].join(", "))
			end 
			return cust
		end #end of self.all

		def self.find(id)
		customer = Grocery::Customer.all
			if id > customer.length || id <= 0
				raise ArgumentError.new("Customer does not exist")
			else
				return customer[id-1]
			end
		end
	end#end of customer class
end #end of Grocery module

