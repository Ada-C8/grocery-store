require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'

# TODO: uncomment the next line once you start wave 3
 require_relative '../lib/online_order'
 require_relative '../lib/order'
 require_relative '../lib/customer'
# You may also need to require other classes here

# Because an OnlineOrder is a kind of Order, and we've
# already tested a bunch of functionality on Order,
# we effectively get all that testing for free! Here we'll
# only test things that are different.

describe "OnlineOrder" do
  describe "#initialize" do
    it "Is a kind of Order" do
      online_order = Grocery::OnlineOrder.new(1, "cat", 34, "dog")
      online_order.must_be_kind_of Grocery::Order
    end

    it "Can access Customer object" do
      # TODO: Your test code here!
      customer = 34
      online_order = Grocery::OnlineOrder.new(1, "cat", customer, "dog")
      online_order.must_respond_to :customer
      online_order.customer.must_equal customer
      online_order.customer.must_be_kind_of Integer

    end

    it "Can access the online order status" do
      # TODO: Your test code here!
      status = :dog
      online_order = Grocery::OnlineOrder.new(1, "cat", 34, status)
      online_order.must_respond_to :status
      online_order.status.must_equal status
      online_order.status.must_be_kind_of Symbol
    end
  end

  describe "#total" do
    it "Adds a shipping fee" do
      # TODO: Your test code here!
      online_order = Grocery::OnlineOrder.new(1, {"banana": 1.00}, 34, "dog")
      online_order.total.must_equal 11.08
    end

    it "Doesn't add a shipping fee if there are no products" do
      # TODO: Your test code here!
      online_order = Grocery::OnlineOrder.new(1, {}, 34, :pending)
      online_order.total.must_equal 0
    end
  end

  xdescribe "#add_product" do
    it "Does not permit action for processing, shipped or completed statuses" do
      # TODO: Your test code here!
      online_order = Grocery::OnlineOrder.new(1, {"banana": 1.00}, 34, :processing)
      proc {online_order.add_product("cat", 2.00)}.must_raise ArgumentError
      online_order = Grocery::OnlineOrder.new(1, {"banana": 1.00}, 34, :shipped)
      proc {online_order.add_product("cat", 2.00)}.must_raise ArgumentError
      online_order = Grocery::OnlineOrder.new(1, {"banana": 1.00}, 34, :completed)
      proc {online_order.add_product("cat", 2.00)}.must_raise ArgumentError
    end

    it "Permits action for pending and paid satuses" do
      # TODO: Your test code here!
      online_order = Grocery::OnlineOrder.new(1, {"banana": 1.00}, 34, :pending)
      online_order.add_product("cat", 1.00).must_equal true
      online_order = Grocery::OnlineOrder.new(1, {"banana": 1.00}, 34, :paid)
      online_order.add_product("cat", 1.00).must_equal true
    end
  end

  describe "OnlineOrder.all" do
    it "Returns an array of all online orders" do
      # TODO: Your test code here!
      online_orders = Grocery::OnlineOrder.all
      #   x OnlineOrder.all returns an array
      online_orders.must_be_instance_of Array
      online_orders[0].id.must_equal 1
      online_orders[0].products["Lobster"].must_equal "17.18"
      #   x Everything in the array is an Order
      online_orders.each do |orders|
        orders.must_be_kind_of Grocery::Order
      end
      #   x The number of orders is correct
      online_orders.length.must_equal 100
      #   x The customer is present
      online_orders[0].customer.must_equal 25
      #   x The status is present
      online_orders[0].status.must_equal :complete

    end
  end

  describe "OnlineOrder.find" do
    it "Can find the first order from the CSV" do
      # TODO: Your test code here!

    Grocery::OnlineOrder.find(1).must_be_instance_of Grocery::OnlineOrder
    end

    it "Can find the last order from the CSV" do
      # TODO: Your test code here!
      Grocery::OnlineOrder.find(100).must_be_instance_of Grocery::OnlineOrder
    end

    it "Raises an error for an order that doesn't exist" do
      # TODO: Your test code here!

      proc {Grocery::OnlineOrder.find(0)}.must_raise ArgumentError
      proc {Grocery::OnlineOrder.find(101)}.must_raise ArgumentError

    end
  end


  describe "OnlineOrder.find_by_customer" do
    it "Returns an array of online orders for a specific customer ID" do
      # TODO: Your test code here!
      Grocery::OnlineOrder.find_by_customer(1).must_be_instance_of Array
    end
  end
end
