require 'csv'

module Grocery	
	class Order
		attr_reader :id, :products  
		
		#ID - string; products - map
		def initialize(id, products)
		  @id = id
		  @products = products
		end

		def self.all()
			myOrders = []
			#row[0] = id | row[1] = orders
			CSV.foreach('../support/orders.csv') { |row|
				order_prodcuts = {}
				order_id = row[0] #this is the ID
				row[1].split(';').each { |i| #this splits the order string into individual name/cost pairs
					single_item = i.split(':')#separates the name from the cost
					cost = single_item[1]
					name = single_item[0]
					order_prodcuts[name] = cost
				}
				myOrders << Grocery::Order.new(order_id, order_prodcuts)
			}
			return myOrders
		end

		def self.find(id)
			orders = Grocery::Order.all #calls the all to get all of the orders 
			orders.each { |i|
				if i.id.to_i == id.to_i
					return i
				end
			}
			raise ArgumentError, 'Order ID #{id} does not exist'
		end
			  
		def add_product(name, cost)
			if @products.include?(name)
				return false
			else
				@products[name] = cost #add a new product to the hash with the name as the key and cost as the value
				return true
			end
		end

		def total
		  before_tax = 0
		  @products.each { |key, value| #takes each key/value pair in the hash and adds the value (cost) to the total
		  	before_tax += value
		  }
		  return before_tax + (before_tax * 0.075).round(2)
		end
	end
end
