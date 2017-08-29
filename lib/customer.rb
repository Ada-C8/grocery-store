require 'csv'

module Grocery
	class Customer 
		attr_reader :id, :email, :address, :city, :state, :zip
		
		def initialize(id, email, address, city, state, zip)
			@id = id
			@email = email
			@address = address
			@city = city
			@state = state
			@zip = zip
		end
		
		def self.all()
			customer = []

			CSV.foreach('../support/customers.csv') { |row|	
				id = row[0]
				email = row[1]
				address = row[2]
				city = row[3]
				state = row[4]
				zip = row[5]
				current = Grocery::Customer.new(id, email, address, city, state, zip)
				customer << current
				
			}
			return customer
		end
		
		def self.find(id)
			customers = Grocery::Customer.all
			customers.each { |i|
				if i.id.to_i == id.to_i
					return i
				end
			}
			raise ArgumentError, "There is no customer with the ID #{id}"
			
		end
	end
end