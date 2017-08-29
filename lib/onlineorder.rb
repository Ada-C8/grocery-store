require 'csv'
require_relative 'order.rb'
require_relative 'customer.rb'

module Grocery
	class OnlineOrder < Order
		attr_reader :id, :products, :customer, :status

		def initialize(id, products, customer, status='pending')
			super(id, products) #call the Order's constructor and passes variables as needed
			@customer = customer
			@status = status
		end
	  
		def self.all()
			online_orders = []
			CSV.foreach('../support/online_orders.csv') { |row| #parses each row in the online_orders CSV
				order_id = row[0]
				customer = row[2]
				status = row[3]
				order_products = {}
				row[1].split(';').each { |i| #like in orders.rb splits products by ;
					single_item = i.split(':') #splits products into the name and cost
					cost = single_item[1]
					name = single_item[0]
					order_products[name] = cost #adds the new prodcut to the hash with the correct value
			}
			online_orders << Grocery::OnlineOrder.new(order_id, order_products, customer, status) 
			}
			return online_orders
		end
		
		def self.find(id)
			orders = Grocery::OnlineOrder.all
			orders.each { |i|
				if i.id.to_i == id.to_i
					return i
				end
			}
			raise ArgumentError, "There is no Order with the ID: #{id}" 
		end
		
		def self.find_by_customer(customer_id)
			customers = Grocery::Customer.all
			customers.each { |i|
				if i.id.to_i == customer_id.to_i
					return i
				end
			}
			raise ArgumentError, 'There is no customer with the ID #{id}'
			
		end
	  
		def add_product(name, cost)
			if @status == 'pending' || @status == 'paid' #checks if the status is valid before doing update
				super(cost, name)
			else
				raise ArgumentError, "You can't add items to your order"
			end
		end
	
		def total
		if @products == {} #if there are no products I don't want to add the shipping accidentally
			return 0
		else
			return super + 10
		end
	end
	
	end
end