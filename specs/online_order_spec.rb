require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'

# TODO: uncomment the next line once you start wave 3
require_relative '../lib/onlineorder'
# You may also need to require other classes here

# Because an OnlineOrder is a kind of Order, and we've
# already tested a bunch of functionality on Order,
# we effectively get all that testing for free! Here we'll
# only test things that are different.

describe "OnlineOrder" do
  describe "#initialize" do
    it "Is a kind of Order" do
      id = 1
	  products = {'socks' => 2.34}
	  customer = 5
	  status = 'paid'
      # Instatiate your OnlineOrder here
      online_order = Grocery::OnlineOrder.new(id, products, customer, status)
      online_order.must_be_kind_of Grocery::OnlineOrder
    end

	it "Can access Customer object" do
		id = 1
		products = {'socks' => 2.34}
		customer = 5
		status = 'paid'
		online_order = Grocery::OnlineOrder.new(id, products, customer, status)

		online_order.must_respond_to :customer
		online_order.customer.must_equal customer
		online_order.customer.must_be_kind_of Integer
    end

    it "Can access the online order status" do
		id = 1
		products = {'socks' => 2.34}
		customer = 5
		status = 'paid'
		online_order = Grocery::OnlineOrder.new(id, products, customer, status)
		
		online_order.must_respond_to :status
		online_order.status.must_equal status
		online_order.status.must_be_kind_of String
    end
  end

  describe "#total" do
    it "Adds a shipping fee" do
		id = 1
		products = {'socks' => 2.34}
		customer = 5
		status = 'paid'
		online_order = Grocery::OnlineOrder.new(id, products, customer, status)
		
		calculated_total = online_order.total
		raw_total = (2.34*1.075).round(2) + 10
		
		calculated_total.must_equal raw_total
    end

    it "Doesn't add a shipping fee if there are no products" do
		id = 1
		products = {}
		customer = 5
		status = 'pending'
		online_order = Grocery::OnlineOrder.new(id, products, customer, status)
		
		total = online_order.total
		
		total.must_equal 0
    end
  end

  describe "#add_product" do
    it "Does not permit action for processing, shipped or completed statuses" do
		id = 1
		products = {'socks' => 2.34}
		customer = 5
		status = 'paid'
		online_order = Grocery::OnlineOrder.new(id, products, customer, status)
    end

    it "Permits action for pending and paid satuses" do
		id = 1
		products = {'socks' => 2.34}
		customer = 5
		status = 'paid'
		online_order = Grocery::OnlineOrder.new(id, products, customer, status)
		count_before = online_order.products.keys.count + 1
		online_order.add_product('shoes', 3)
		count_after = online_order.products.keys.count
		
		count_after.must_equal count_before
    end
  end

  describe "OnlineOrder.all" do
    it "Returns an array of all online orders" do
		online_orders = Grocery::OnlineOrder.all
		
		online_orders.must_be_kind_of Array
		
		online_orders.each { |i|
			i.must_be_kind_of Grocery::OnlineOrder
			i.must_respond_to :customer
			i.must_respond_to :status
		}
		
		raw_orders = []
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
			
			raw_orders << Grocery::OnlineOrder.new(order_id, order_products, customer, status) 
		}
		
		online_orders.length.must_equal raw_orders.length
	end
  end
  
  describe "OnlineOrder.find_by_customer" do
    it "Returns an array of online orders for a specific customer ID" do
		a = Grocery::OnlineOrder.find_by_customer(1)
		a.must_be_kind_of Grocery::Customer
	end
  end
end
