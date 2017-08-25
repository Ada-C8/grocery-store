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

xdescribe "OnlineOrder" do
  describe "#initialize" do
    it "Is a kind of Order" do
      # Check that an OnlineOrder is in fact a kind of Order
      status = "paid"
      online_order = OnlineOrder.new(order, customer, status)
      online_order.is_kind_of Grocery::Order
      online_order.must_be_instance_of Grocery::OnlineOrder
    end

    it "Status is stored as a symbol" do
      # check that status is symbol
      status = "paid"
      online_order = OnlineOrder.new(order, customer, status)
      online_order.status.is_kind_of Symbol
    end

    it "Can access Customer object" do
      # TODO: Your test code here!
      OnlineOrder.all[0].status.must_equal :complete
      OnlineOrder.all[99].status.must_equal :pending
    end

    it "Can access the online order status" do
      # TODO: Your test code here!
      OnlineOrder.all[0].status.must_equal :complete
      OnlineOrder.all[99].status.must_equal :pending
    end
  end

  describe "#total" do
    it "Adds a shipping fee" do
      # TODO: Your test code here!
    end

    it "Doesn't add a shipping fee if there are no products" do
      # TODO: Your test code here!
    end
  end

  describe "#add_product" do
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
      # Useful checks might include:
      #   - OnlineOrder.all returns an array
      #   - Everything in the array is an Order
      #   - The number of orders is correct
      #   - The customer is present
      #   - The status is present
      # Feel free to split this into multiple tests if needed

      it "Can access the online order status" do
        # ensure status for first and last online orders are correct
        OnlineOrder.all[0].status.must_equal :complete
        OnlineOrder.all[99].status.must_equal :pending
      end
    end
  end

  describe "OnlineOrder.find_by_customer" do
    it "Returns an array of online orders for a specific customer ID" do
      # TODO: Your test code here!
    end
  end
end
