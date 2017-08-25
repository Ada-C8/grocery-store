require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/online_order'
require_relative '../lib/order'

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new


# TODO: uncomment the next line once you start wave 3
# require_relative '../lib/online_order'
# You may also need to require other classes here

# Because an OnlineOrder is a kind of Order, and we've
# already tested a bunch of functionality on Order,
# we effectively get all that testing for free! Here we'll
# only test things that are different.

describe "OnlineOrder" do
  describe "#initialize" do
    it "Is a kind of Order" do
      # Check that an OnlineOrder is in fact a kind of Order
      # Instatiate your OnlineOrder here
       online_order = Grocery::OnlineOrder.new("3", {apple: 2, pear: 3}, "1", "Paid")
      online_order.must_be_kind_of Grocery::Order
    end

    it "Can access Customer object" do
      # TODO: Your test code here!
      online_order = Grocery::OnlineOrder.new("3", {apple: 2, pear: 3}, "1", "Paid")
      # online_order.must_respond_to :customer_id
      online_order.customer_id.must_equal "1"
    end

    it "Can access the online order status" do
      # TODO: Your test code here!
      online_order = Grocery::OnlineOrder.new("3", {apple: 2, pear: 3}, "1", "Paid")
      online_order.status.must_equal "Paid"
    end
  end

  describe "#total" do
    it "Adds a shipping fee" do
      # TODO: Your test code here!
      online_order = Grocery::OnlineOrder.new("3", {apple: 2, pear: 3}, "1", "Paid")
      online_order.total.must_equal ((5 + (5 * 0.075)).round(2) + 10)
    end

    it "Doesn't add a shipping fee if there are no products" do
      # TODO: Your test code here!
      online_order = Grocery::OnlineOrder.new("3", {}, "1", "Paid")
      online_order.total.must_equal 0
    end
  end

  describe "#add_product" do
    it "Does not permit action for processing statuses" do
      # TODO: Your test code here!
      online_order = Grocery::OnlineOrder.new("3", {apple: 2, pear: 3}, "1", "processing")
      proc {online_order.add_product}.must_raise ArgumentError
      # proc {Grocery::Order.find(yay_orders.length + 1)}.must_raise ArgumentError
    end #processing

    it "Does not permit action for shipped statuses" do
      online_order = Grocery::OnlineOrder.new("3", {apple: 2, pear: 3}, "1", "shipped")
      proc {online_order.add_product}.must_raise ArgumentError
    end #shipped

    it "Does not permit action for completed statuses" do
      online_order = Grocery::OnlineOrder.new("3", {apple: 2, pear: 3}, "1", "completed")
      proc {online_order.add_product}.must_raise ArgumentError
    end #completed

    it "Permits action for pending satuses" do
      online_order = Grocery::OnlineOrder.new("3", {apple: 2, pear: 3}, "1", "pending")
      online_order.add_product("kiwi", 5).must_equal true
    end

    it "Permits action for pending satuses" do
      online_order = Grocery::OnlineOrder.new("3", {apple: 2, pear: 3}, "1", "paid")
      online_order.add_product("kiwi", 5).must_equal true
    end

  end #describe "#add_product" do

  describe "OnlineOrder.all" do
    it "Returns an array of all online orders" do
      # TODO: Your test code here!
      # Useful checks might include:
      #   - OnlineOrder.all returns an array
      #   - Everything in the array is an Order
      #   - The number of orders is correct
      #   - The customer is present
      #   - The status is present
      # Feel free to split this into multiple tests if needed
    end
  end

  describe "OnlineOrder.find_by_customer" do
    it "Returns an array of online orders for a specific customer ID" do
      # TODO: Your test code here!
    end
  end
end
