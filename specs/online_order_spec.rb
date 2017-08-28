require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/online_order'

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
      #Instatiate your OnlineOrder here
      online_order = Grocery::OnlineOrder.new(1, {}, 123)
      online_order.must_be_kind_of Grocery::Order
    end

    it "Can access Customer object" do
      # TODO: Your test code here!
      online_order = Grocery::OnlineOrder.new(1, {}, 234)
      (online_order.customer_id).wont_be_nil
    end

    it "Can access the online order status" do
      # TODO: Your test code here!
      online_order = Grocery::OnlineOrder.new(1, {}, 23)
      (online_order.fulfillment_status).wont_be_nil
    end
  end

  describe "#total" do
    it "Adds a shipping fee" do
      # TODO: Your test code here!
      online_order = Grocery::OnlineOrder.new(1, {"bulk spaghetti" => 10}, 23)
      (online_order.total).must_equal 20.75
    end

    it "Doesn't add a shipping fee if there are no products" do
      # TODO: Your test code here!
      online_order = Grocery::OnlineOrder.new(1, {}, 23)
      (online_order.total).must_equal 0
    end
  end

  describe "#add_product" do
    it "Does not permit action for processing, shipped or completed statuses" do
      # TODO: Your test code here!
      online_order = Grocery::OnlineOrder.new(1, {"pigs feet" => 3.90}, 23, "completed")
      proc{online_order.add_product("jell-o", 0.99)}.must_raise ArgumentError
    end

    it "Permits action for pending and paid satuses" do
      # TODO: Your test code here!
      online_order = Grocery::OnlineOrder.new(1, {"pigs feet" => 3.90}, 23, "pending")
      online_order.add_product("jell-o", 0.99).must_equal true
    end
  end

  describe "OnlineOrder.all" do
    it "Returns an array of all online orders" do
      # TODO: Your test code here!
      # Useful checks might include:
      #   - OnlineOrder.all returns an array
      (Grocery::OnlineOrder.all).must_be_kind_of Array
      #   - Everything in the array is an Order
      (Grocery::OnlineOrder.all).each do |online_order|
        online_order.must_be_instance_of Grocery::OnlineOrder
      end
      #   - The number of orders is correct
      ((Grocery::OnlineOrder.all).length).must_equal 100
      #   - The customer is present
      #   - The status is present
      (Grocery::OnlineOrder.all).each do |online_order|
        (online_order.customer_id).wont_be_nil
        (online_order.fulfillment_status).wont_be_nil
      end

      # Feel free to split this into multiple tests if needed
    end
  end

  describe "OnlineOrder.find_by_customer" do
    it "Returns an array of online orders for a specific customer ID" do
      # TODO: Your test code here!
      (Grocery::OnlineOrder.find_by_customer(23)).must_be_instance_of Array
    end
  end
end
