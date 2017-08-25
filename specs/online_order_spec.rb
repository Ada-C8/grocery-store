require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'

# TODO: uncomment the next line once you start wave 3
require_relative '../lib/online_order'
require_relative '../lib/customer'
# You may also need to require other classes here

# Because an OnlineOrder is a kind of Order, and we've
# already tested a bunch of functionality on Order,
# we effectively get all that testing for free! Here we'll
# only test things that are different.

describe "OnlineOrder" do
  describe "#initialize" do
    before do
      @online_order = Grocery::OnlineOrder.new(3, {"fish" => 123}, Grocery::Customer.new(12, "mom@mom.com", "Planettown"), :pending)
      @online_order_without_status = Grocery::OnlineOrder.new(3, {"fish" => 123}, Grocery::Customer.new(12, "mom@mom.com", "Planettown"))
    end

    it "Is a kind of Order" do
      # Check that an OnlineOrder is in fact a kind of Order

      # Instatiate your OnlineOrder here
      @online_order.must_be_kind_of Grocery::Order
    end

    it "Can access products object" do
      @online_order.products.must_be_instance_of Hash
    end

    it "Can access Customer object" do
      @online_order.customer.must_be_instance_of Grocery::Customer
    end

    it "Can access the online order status" do
      @online_order.status.must_be_instance_of Symbol
      @online_order_without_status.status.must_be_instance_of Symbol
      @online_order_without_status.status.must_equal :pending
    end
  end

  describe "#total" do
    before do
      @online_order = Grocery::OnlineOrder.new(3, {"fish" => 12.00, "banana" => 18.00}, Grocery::Customer.new(12, "mom@mom.com", "Planettown"), :pending)
      @online_order_without_products = Grocery::OnlineOrder.new(3, {}, Grocery::Customer.new(12, "mom@mom.com", "Planettown"))
    end

    it "Adds a shipping fee" do
      @online_order.total.must_be_instance_of Float
      @online_order.total.must_equal 42.25

    end

    it "Doesn't add a shipping fee if there are no products" do
      @online_order_without_products.total.must_equal 0
    end
  end

  describe "#add_product" do
    before do
      @online_order_shipped = Grocery::OnlineOrder.new(3, {"fish" => 12.00, "banana" => 18.00}, Grocery::Customer.new(12, "mom@mom.com", "Planettown"), :shipped)
      @online_order_pending = Grocery::OnlineOrder.new(3, {"fish" => 12.00, "banana" => 18.00}, Grocery::Customer.new(12, "mom@mom.com", "Planettown"), :pending)
    end

    it "Does not permit action for processing, shipped or completed statuses" do
      # Should return an ArgumentError
      proc {@online_order_shipped.add_product("apple", 12.3)}.must_raise ArgumentError

    end

    it "Permits action for pending and paid statuses & product isn't in customer's existing product list" do
      # TODO: Your test code here!
      @online_order_pending.must_respond_to(:add_product)
      @online_order_pending.add_product("apple", 12.3).must_equal true

    end

    it "Does not permit action for pending and paid satuses when product is in customer's existing product list" do
      # TODO: Your test code here!
      @online_order_pending.add_product("banana", 12.3).must_equal false

    end
  end

  describe "OnlineOrder.all an array of all online orders" do

      #   - OnlineOrder.all returns an array

    it "OnlineOrder.all returns an array" do
      Grocery::OnlineOrder.must_respond_to :all
      Grocery::OnlineOrder.all.must_be_instance_of Array
    end
    #   - Everything in the array is an Order
    it "OnlineOrder.all array contains OnlineOrder objects" do
      Grocery::OnlineOrder.all[rand(0..100)].must_be_instance_of Grocery::OnlineOrder
    end
    #   - The number of orders is correct
    it "Has the correct number of online orders initialized" do
      Grocery::OnlineOrder.all.length.must_equal 100
    end
    #   - The customer is present
    it "Has OnlineOrder objects that have Customer objects" do
      Grocery::OnlineOrder.all[rand(0..100)].customer.must_be_instance_of Grocery::Customer
    end
    #   - The status is present
    it "Has OnlineOrder objects that have statuses" do
      Grocery::OnlineOrder.all[rand(0..100)].status.must_be_instance_of Symbol
    end

  end

  describe "OnlineOrder.find_by_customer" do
    it "Returns an array of online orders for a specific customer ID" do
      # TODO: Your test code here!
    end
  end
end
