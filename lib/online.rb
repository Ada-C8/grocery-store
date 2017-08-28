require_relative "order.rb"
require_relative "customer.rb"
module Grocery
	class OnlineOrder < Grocery::Order
		attr_reader :order, :customer, :status, :id, :products

		def initialize(id, products, customer, status = "pending")
			@id = id
			@products = products
			@customer = customer
			@status = status.to_sym
			@order = super(id, products)
		end #end intitalize

		def total
			if @products.empty?
				super 
			else
				super + 10
			end
		end #end total

		def add_product(name, price)
			if status == :pending || status == :paid
				return super
			else raise ArgumentError.new("The product isn't paid or pending")
			end
		end #end add_product

		def self.all
			online_orders = []
			CSV.open("support/online_orders.csv", "r").each do |line|
				all_data = []
				product_string = line[1]
				product_data = product_string.split(/:|;/)
				product_data.each_with_index do |food, array|
					if array % 2 == 0
						all_data << food.to_s
					elsif array % 2 == 1
						all_data << food.to_f.round(2)
					end
				end
				online_orders.push(OnlineOrder.new(line[0].to_i, Hash[*all_data], Grocery::Customer.find(line[2].to_i), line[3]))
			end
			return online_orders
		end #end self.all

		def self.find(id)
			return super
		end #end self.find(id)

		def self.find_by_customer(customer_id)
			cust_orders = []
			OnlineOrder.all.each do |online|
				puts online
				if customer_id == online.customer.id
					cust_orders.push(online)
				end
			end
			return cust_orders
		end #end self.find(find_by_cust)
	end #end of onlineorder class
end #end of module

