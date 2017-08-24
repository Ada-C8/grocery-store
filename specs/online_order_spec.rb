require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'

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
      # Check that an OnlineOrder is in fact a kind of Order
      online_order = OnlineOrder.new(3)
      online_order.must_be_kind_of Grocery::Order
    end

    it "Can access Customer object" do
      online_order = OnlineOrder.new(3, :paid)
      online_order.must_respond_to :customer
      online_order.customer.must_equal 3
    end

    it "Can access the online order status" do
      online_order = OnlineOrder.new(3, :paid)
      online_order.must_respond_to :status
      online_order.status.must_equal :paid
    end

    it "Has default order status of :pending" do
      online_order = OnlineOrder.new(3)
      online_order.status.must_equal :pending
    end
  end

  describe "#total" do
    it "Adds a shipping fee" do
      reg_order = Grocery::Order.new(1337, {"banana" => 1.0, "apple" => 1.25, "whole milk" => 3.59})
      online_order = OnlineOrder.new(3, :pending, {"banana" => 1.0, "apple" => 1.25, "whole milk" => 3.59})
      online_order.total.must_equal (reg_order.total + 10)# TODO: Your test code here!
    end

    it "Doesn't add a shipping fee if there are no products" do
      online_order = OnlineOrder.new(3)
      online_order.total.must_equal 0# TODO: Your test code here!
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

  xdescribe "OnlineOrder.all" do
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

  xdescribe "OnlineOrder.find_by_customer" do
    it "Returns an array of online orders for a specific customer ID" do
      # TODO: Your test code here!
    end
  end
end
