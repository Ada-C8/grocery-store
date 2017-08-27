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

  xdescribe "#total" do
    it "Adds a shipping fee" do
      # TODO: Your test code here!
    end

    it "Doesn't add a shipping fee if there are no products" do
      # TODO: Your test code here!
    end
  end

  xdescribe "#add_product" do
    it "Does not permit action for processing, shipped or completed statuses" do
      # TODO: Your test code here!
    end

    it "Permits action for pending and paid satuses" do
      # TODO: Your test code here!
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

  xdescribe "OnlineOrder.find_by_customer" do
    it "Returns an array of online orders for a specific customer ID" do
      # TODO: Your test code here!
    end
  end
end
