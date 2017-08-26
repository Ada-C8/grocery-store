require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'

# TODO: uncomment the next line once you start wave 3
require_relative '../lib/online_order'
require_relative '../lib/order'
# You may also need to require other classes here

# Because an OnlineOrder is a kind of Order, and we've
# already tested a bunch of functionality on Order,
# we effectively get all that testing for free! Here we'll
# only test things that are different.

describe "OnlineOrder" do
  describe "#initialize" do
    it "Is a kind of Order" do
      id = 12
      products = { "banana" => 1.99, "cracker" => 3.00 }
      customer_id = 1
      status = :pending
      online_order = Grocery::OnlineOrder.new(id, products, customer_id, status)

      online_order.must_be_kind_of Grocery::Order
    end

    it "Can access Customer object" do
      id = 12
      products = { "banana" => 1.99, "cracker" => 3.00 }
      customer_id = 1
      status = :pending
      online_order = Grocery::OnlineOrder.new(id, products, customer_id, status)

      online_order.must_respond_to :customer
    end

    it "Can access the online order status" do
      id = 12
      products = { "banana" => 1.99, "cracker" => 3.00 }
      customer_id = 1
      status = :pending
      online_order = Grocery::OnlineOrder.new(id, products, customer_id, status)

      online_order.must_respond_to :status
    end
  end

  describe "#total" do
    it "Adds a shipping fee" do
      id = 12
      products = { "banana" => 1.99, "cracker" => 3.00 }
      customer_id = 1
      status = :pending
      online_order = Grocery::OnlineOrder.new(id, products, customer_id, status)
      instore_order = Grocery::Order.new(id, products)

      online_order.total.must_equal instore_order.total + 10
    end

    it "Doesn't add a shipping fee if there are no products" do
      id = 12
      products = {}
      customer_id = 1
      status = :pending
      online_order = Grocery::OnlineOrder.new(id, products, customer_id, status)
      instore_order = Grocery::Order.new(id, products)

      online_order.total.must_equal instore_order.total
    end
  end

  describe "#add_product" do
    it "Does not permit action for processing, shipped or completed statuses" do
      id = 12
      products = { "banana" => 1.99, "cracker" => 3.00 }
      customer_id = 1
      status = :shipping
      online_order = Grocery::OnlineOrder.new(id, products, customer_id, status)

      online_order.add_product("apple", 3.00)
      online_order.products.must_equal products

    end

    it "Permits action for pending and paid satuses" do
      id = 12
      products = { "banana" => 1.99, "cracker" => 3.00 }
      customer_id = 1
      status = :pending
      online_order = Grocery::OnlineOrder.new(id, products, customer_id, status)
      updated_products ={ "banana" => 1.99, "cracker" => 3.00, "apple" => 3.00}

      online_order.add_product("apple", 3.00)
      online_order.products.must_equal updated_products
    end
  end

  describe "OnlineOrder.all" do
    it "Returns an array" do
      all_online_orders =Grocery::OnlineOrder.all
      all_online_orders.must_be_kind_of Array
    end

    #Note, think about changing other similar methods to a each loop
    it "Everything in the array is an Order" do
      all_online_orders =Grocery::OnlineOrder.all
      all_online_orders.each do |single_order|
        single_order.must_be_kind_of Grocery::Order
      end
    end

    it "The number of orders in the array equals the number in the csv file" do
      all_online_orders =Grocery::OnlineOrder.all
      csv_length = CSV.read("support/online_orders.csv", 'r').length
      all_online_orders.length.must_equal csv_length
    end

    it "You can access the Customer class and it's methods" do
      all_online_orders =Grocery::OnlineOrder.all
      all_online_orders.each do |one_online_order|
        one_online_order.must_respond_to :customer
        one_online_order.customer.must_respond_to :customer_id
        one_online_order.customer.must_respond_to :email
        one_online_order.customer.must_respond_to :address
      end
    end

    it "The status is present" do
      all_online_orders =Grocery::OnlineOrder.all
      all_online_orders.each do |one_online_order|
        one_online_order.must_respond_to :status
      end
    end
  end

  describe "OnlineOrder.find_by_customer" do
    #it "Returns an array of online orders for a specific customer ID" do
    # TODO: Your test code here!
    it "Returns an array" do
      online_orders = Grocery::OnlineOrder.find_by_customer(14)
      online_orders.must_be_kind_of Array
    end

    it "The objects in the array are orders" do
      online_orders = Grocery::OnlineOrder.find_by_customer(14)
      online_orders.each do |order|
        order.must_be_kind_of Grocery::Order
      end

    end

    it "Can find the all the orders from a single customer" do
      online_orders = Grocery::OnlineOrder.find_by_customer(14)

      find_orders =[]
      online_orders.each do |order|
         find_orders << order.products
      end
      find_orders = find_orders.join
      find_orders = find_orders.delete("{").delete("}").delete("\"").delete("=>")
      find_orders

      csv = CSV.open("support/online_orders.csv", 'r')
      csv_orders = []
      csv.each do |line|
        if line[-2].to_i == 14
          csv_orders << line[1...-2]
        end
      end
      puts ""
      csv_orders = csv_orders.join.delete(":")
      csv_orders = csv_orders.gsub(/([;])/, ", ")

          find_orders.must_equal csv_orders
    end

    it "Raises an error if the customer did not place and online order" do
      proc {Grocery::OnlineOrder.find_by_customer(1000)}.must_raise ArgumentError
    end
  end
end
