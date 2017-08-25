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
  describe "#initialize" do
    before do
      #test data
      id = 1500
      products = {"Spumoni" => 9.87}
      customer_id = 3333
      status = "completed"
      @test_order = Grocery::OnlineOrder.new(id, products, customer_id, status)
    end
    it "Is a kind of Order" do
      @test_order.must_be_kind_of Grocery::Order
    end

    it "Can access Customer object" do
      @test_order.c_id.must_equal 3333
    end

    it "Can access the online order status" do
      @test_order.status.must_equal "completed"
    end
  end

  describe "#total" do
    before do
      #test data
      id = 1500
      products = {"Spumoni" => 9.87}
      customer_id = 3333
      status = "completed"
      @test_order = Grocery::OnlineOrder.new(id, products, customer_id, status)
    end

    it "Adds a shipping fee" do
      @test_order.total.must_equal (10.61 + 10)
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
    end
  end

  describe "OnlineOrder.find_by_customer" do
    it "Returns an array of online orders for a specific customer ID" do
      # TODO: Your test code here!
    end
  end
end
