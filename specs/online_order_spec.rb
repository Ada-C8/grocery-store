
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

describe "OnlineOrder" do
  before do
    @online_order = Grocery::OnlineOrder.new(1, {"Lobster" => 17.18, "Annatto seed" => 58.38, "Camomile" => 83.21}, 25, :completed)


  end
  describe "#initialize" do
    it "Is a kind of Order" do
      # Check that an OnlineOrder is in fact a kind of Order
      @online_order.must_be_kind_of Grocery::Order
      # Instatiate your OnlineOrder here
      # online_order =
      # online_order.must_be_kind_of Grocery::Order
    end

    it "Can access Customer object" do
      # TODO: Your test code here!
      @online_order.customer(22).must_equal Grocery::Customer.find(22)
    end

    it "Can access the online order status" do
      # TODO: Your test code here!
      @online_order.must_respond_to :status
    end
  end

  describe "#total" do
    it "Adds a shipping fee" do
        order = Grocery::Order.new(1, {"Lobster" => 17.18, "Annatto seed" => 58.38, "Camomile" => 83.21})
      # TODO: Your test code here!
      @online_order.total.must_equal (order.total + 10)
      # (180.68)
    end

    it "Doesn't add a shipping fee if there are no products" do
      product_free = Grocery::OnlineOrder.new(35, {}, 25, :completed)
      # TODO: Your test code here!
      product_free.total.must_equal 0
    end
  end

  describe "#add_product" do
    it "Does not permit action for processing, shipped or completed statuses" do
      # TODO: Your test code here!
      @online_order.add_product("Kale", 2.99).must_equal false
    end

    it "Permits action for pending and paid satuses" do
      pending = Grocery::OnlineOrder.new(1, {"Lobster" => 17.18, "Annatto seed" => 58.38, "Camomile" => 83.21}, 25, :paid)
      # TODO: Your test code here!
      pending.add_product("Kale", 2.99).must_equal true
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
