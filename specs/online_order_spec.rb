require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'

# TO-DO: uncomment the next line once you start wave 3
require_relative '../lib/online_order'
# You may also need to require other classes here

# Because an OnlineOrder is a kind of Order, and we've
# already tested a bunch of functionality on Order,
# we effectively get all that testing for free! Here we'll
# only test things that are different.

describe "OnlineOrder" do
  before do
    online_id = 1
    products = {"Lobster" => 17.18, "Annatto seed" => 58.38, "Camomile" => 83.21}
    customer_id = 25
    status = :complete

    @online_order = Grocery::OnlineOrder.new(online_id, products, customer_id, status)
  end

  describe "#initialize" do
    it "Is a kind of Order" do
      # Check that an OnlineOrder is in fact a kind of Order
      @online_order.must_be_kind_of Grocery::Order
    end

    it "Can access Customer object" do #customer object = instance of customer
      @online_order.customer_id.must_be_instance_of Grocery::Customer
    end

    it "Can access the online order status" do
      @online_order.status.must_be_kind_of Symbol
    end
  end

  describe "#total" do
    it "Adds a shipping fee" do
      test_total = 17.18 + 58.38 + 83.21
      @online_order.total.must_equal(test_total + (test_total * 0.075).round(2) + 10) #beware of rounding errors!
    end

    it "Doesn't add a shipping fee if there are no products" do
      online_id = 101
      products = {}
      customer_id = 20
      status = :pending

      no_products_order = Grocery::OnlineOrder.new(online_id, products, customer_id, status)
      no_products_order.total.must_equal(0)
    end
  end

  xdescribe "#add_product" do
    xit "Does not permit action for processing, shipped or completed statuses" do
      # TODO: Your test code here!
    end

    xit "Permits action for pending and paid satuses" do
      # TODO: Your test code here!
    end
  end

  xdescribe "OnlineOrder.all" do
    xit "Returns an array of all online orders" do
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
    xit "Returns an array of online orders for a specific customer ID" do
      # TODO: Your test code here!
    end
  end
end
