require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
# require_relative '../lib/online_order'

# TODO: uncomment the next line once you start wave 3
require_relative '../lib/online_order'
# You may also need to require other classes here

# Because an OnlineOrder is a kind of Order, and we've
# already tested a bunch of functionality on Order,
# we effectively get all that testing for free! Here we'll
# only test things that are different.

describe "OnlineOrder" do
  describe "#initialize" do
    it "Is a kind of Order" do
      online_order = Grocery::OnlineOrder.new(10, {"Jerusalem Artichoke" => 59.92}, 26, :complete)
      (online_order.is_a? Grocery::Order).must_equal true
    end

    it "Can access Customer object" do
      online_order = Grocery::OnlineOrder.new(10, {"Jerusalem Artichoke" => 59.92}, 26, :complete)
      online_order.customer.must_be_instance_of Grocery::Customer
    end

    it "Can access the online order status" do
      online_order = Grocery::OnlineOrder.new(10, {"Jerusalem Artichoke" => 59.92}, 26, :complete)
      online_order.status.must_equal :complete
    end
  end

  describe "#total" do
    it "Adds a shipping fee" do
      products = { "banana" => 1.99, "cracker" => 3.00 }
      online_order = Grocery::OnlineOrder.new(1337, products, 26, :complete)

      sum = products.values.inject(0, :+)
      expected_total = sum + (sum * 0.075).round(2) + 10

      online_order.total.must_equal expected_total

    end

    it "Doesn't add a shipping fee if there are no products" do
      products = {}
      online_order = Grocery::OnlineOrder.new(1337, products, 26, :complete)

      expected_total = 0
      online_order.total.must_equal expected_total
    end
  end

  describe "#add_product" do
    it "Does not permit action for processing, shipped or completed statuses" do
      statuses = [:processing, :shipped, :complete]
      statuses.each do |status|

        products = { "banana" => 1.99, "cracker" => 3.00 }
        online_order = Grocery::OnlineOrder.new(1337, products, 26, status)

        proc {online_order.add_product}.must_raise ArgumentError
      end
    end

    it "Permits action for pending and paid satuses" do
      [:pending, :paid].each do |status|
        products = { "banana" => 1.99, "cracker" => 3.00 }
        before_count = products.count
        online_order = Grocery::OnlineOrder.new(1337, products, 26, status)

        online_order.add_product("salad", 4.25)
        expected_count = before_count + 1
        online_order.products.count.must_equal expected_count
      end

      products = { "banana" => 1.99, "cracker" => 3.00 }
      online_order = Grocery::OnlineOrder.new(1337, products, 26, :pending)

      online_order.add_product("sandwich", 4.25)
      online_order.products.include?("sandwich").must_equal true

    end
  end

  describe "OnlineOrder.all" do
    it "Returns an array of all online orders" do
      #Verifies that the return is an Array
      Grocery::OnlineOrder.all('./support/online_orders.csv').must_be_instance_of Array

      #All elements in the array are Order[s]
      Grocery::OnlineOrder.all('./support/online_orders.csv').each do |online_order|
        (online_order.is_a? Grocery::Order).must_equal true
      end

      #The numer of orders is correct
      Grocery::OnlineOrder.all('./support/online_orders.csv').length.must_equal 100

      #customer is present
      Grocery::OnlineOrder.all('./support/online_orders.csv').each do |online_order|
        online_order.customer.must_be_instance_of Grocery::Customer
      end

      Grocery::OnlineOrder.all('./support/online_orders.csv').each do |online_order|
        online_order.customer.must_be_instance_of Grocery::Customer
      end

      #Status is present
      statuses = [:pending, :paid, :processing, :shipped, :complete]

      Grocery::OnlineOrder.all('./support/online_orders.csv').each do |online_order|
        statuses.include?(online_order.status).must_equal true
      end

      # TODO: Your test code here!
      # Useful checks might include:
      #   + OnlineOrder.all returns an array
      #   + Everything in the array is an Order
      #   + The number of orders is correct
      #   + The customer is present
      #   + The status is present
      # Feel free to split this into multiple tests if needed
    end
  end

  describe "OnlineOrder.find" do
    it "Can find the first order from the CSV" do
      order = Grocery::OnlineOrder.find_id(1, './support/online_orders.csv')
      order.id.must_equal 1
    end

    it "Can find the last order from the CSV" do
      order = Grocery::OnlineOrder.find_id(100,'./support/online_orders.csv')
      order.id.must_equal 100
    end

    it "Raises an error for an order that doesn't exist" do
      proc {Grocery::OnlineOrder.find_id(0, './support/online_orders.csv')}.must_raise ArgumentError
    end
  end


  describe "OnlineOrder.find_by_customer" do
    it "Returns an array of online orders for a specific customer ID" do

      order = Grocery::OnlineOrder.find_by_customer(20, './support/online_orders.csv')

      order.must_be_instance_of Array

      order.length.must_equal 7

      order[0].status.must_equal :complete

      order[0].id.must_equal 12

      proc {Grocery::OnlineOrder.find_by_customer(123, './support/online_orders.csv')}.must_raise ArgumentError

    end
  end
end
