require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/order.rb'
require_relative '../lib/online_order'


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
      id = 1337
      food_and_price = {}
      customer_id = 5
      status = :pending
      customer_object = {}
      online_order = Grocery::OnlineOrder.new(id, food_and_price, customer_id, customer_object, status)
      online_order.total.must_equal 0
    end
  end


  describe "#add_product" do
    it "Does not permit action for processing, shipped or completed statuses" do
      order = Grocery::OnlineOrder.find("./support/online_orders.csv", 5)

      proc {order.add_product("muffin", 2.00)}.must_raise ArgumentError
    end

    it "Permits action for pending and paid statuses" do
      order = Grocery::OnlineOrder.find("./support/online_orders.csv", 6)

      order.must_respond_to :add_product

      order.add_product("muffin", 2.00)

      order.food_and_price.has_key?("muffin").must_equal true

    end
  end

  describe "OnlineOrder.all" do
    it "Returns an array of all online orders" do
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
