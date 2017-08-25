require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'

# Todo: uncomment the next line once you start wave 3
require_relative '../lib/online_order'
# You may also need to require other classes here
require_relative '../lib/order'
# Because an OnlineOrder is a kind of Order, and we've
# already tested a bunch of functionality on Order,
# we effectively get all that testing for free! Here we'll
# only test things that are different.

describe "OnlineOrder" do

  before do
    @online_order = OnlineOrder.new(23, {"Cherries" => 90.16}, 10, "complete")
  end

  describe "#initialize" do
    it "Is a kind of Order" do
      @online_order.must_be_kind_of Grocery::Order
    end

    it "Can access Customer object" do
      @online_order.customer.must_be_kind_of Grocery::Customer
    end

    xit "Can access the online order status" do
      # todo: Your test code here!
    end
  end

  xdescribe "#total" do
    it "Adds a shipping fee" do
      # todo: Your test code here!
    end

    it "Doesn't add a shipping fee if there are no products" do
      # todo: Your test code here!
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
