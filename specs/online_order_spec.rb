require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'

# TODO: uncomment the next line once you start wave 3
require_relative '../lib/order.rb'
require_relative '../lib/online_order'
# You may also need to require other classes here

# Because an OnlineOrder is a kind of Order, and we've
# already tested a bunch of functionality on Order,
# we effectively get all that testing for free! Here we'll
# only test things that are different.

describe "OnlineOrder" do
  describe "#initialize" do
    it "Is a kind of Order" do
      id = 1337
      food_and_price = {}
      customer_id = 5
      status = :pending
      customer_object = {}
      online_order = Grocery::OnlineOrder.new(id, food_and_price, customer_id, customer_object, status)
      online_order.must_be_kind_of Grocery::Order
    end

    it "Can access Customer object" do
      Grocery::OnlineOrder.find("./support/online_orders.csv", 1).customer_object.class.must_equal Grocery::Customer

      Grocery::OnlineOrder.find("./support/online_orders.csv", 50).customer_object.class.must_equal Grocery::Customer
    end

    it "Can access the online order status" do
      Grocery::OnlineOrder.find("./support/online_orders.csv", 1).status.must_equal :complete

      Grocery::OnlineOrder.find("./support/online_orders.csv", 100).status.must_equal :pending
    end
  end

  describe "#total" do
    it "Adds a shipping fee" do
      order = Grocery::OnlineOrder.find("./support/online_orders.csv", 1)
      order.total.must_equal 180.68


    end

    it "Doesn't add a shipping fee if there are no products" do
      # TODO: Your test code here!
    end
  end

  describe "#add_product" do
    it "Does not permit action for processing, shipped or completed statuses" do
      id = 1337
      food_and_price = {}
      customer_id = 5
      status = :pending
      customer_object = {}
      online_order = Grocery::OnlineOrder.new(id, food_and_price, customer_id, customer_object, status)
      online_order.total.must_equal 0
    end

    it "Permits action for pending and paid satuses" do
      # TODO: Your test code here!
    end
  end

  describe "OnlineOrder.all" do
    it "Returns an array of all online orders" do
      # TODO: Your test code here!
      # Useful checks might include:
      #   - Everything in the array is an Order

      all_the_online_orders = Grocery::OnlineOrder.all("./support/online_orders.csv")
      all_the_online_orders.must_be_instance_of Array

      all_the_online_orders.length.must_equal 100

      all_the_online_orders[2].must_respond_to :customer_object

      all_the_online_orders[97].must_respond_to :status

      all_the_online_orders.each do |check|
        (check.is_a? Grocery::Order).must_equal true 
      end

    end
  end

  describe "OnlineOrder.find_by_customer" do
    it "Returns an array of online orders for a specific customer ID" do

      Grocery::OnlineOrder.find_by_customer("./support/online_orders.csv", 2).must_be_instance_of Array

      Grocery::OnlineOrder.find_by_customer("./support/online_orders.csv", 1000).length.must_equal 0
    end
  end
end
