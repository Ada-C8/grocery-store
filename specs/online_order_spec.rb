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
  before do
    @online_order = Grocery::OnlineOrder.new(111, {"stuff" => 3.41}, 3, :complete)
  end
  describe "#initialize" do
    it "Is a kind of Order" do
      @online_order.must_be_kind_of Grocery::Order
    end

    it "Can access Customer object" do
      @online_order.customer.must_be_instance_of Grocery::Customer
    end

    it "Can access the online order status" do
      @online_order.status.must_be_instance_of Symbol

      @online_order.status.must_equal :complete
    end
  end

  xdescribe "#total" do
    before do
      #online_order = OnlineOrder.new()
    end
    it "Adds a shipping fee" do
      #total of the items must not match total at checkout
    end

    it "Doesn't add a shipping fee if there are no products" do
      #if there are no products in the order, the shipping fee is 0
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
      Grocery::OnlineOrder.all.must_be_instance_of Array
      Grocery::OnlineOrder.all.sample.must_be_instance_of Grocery::OnlineOrder
      Grocery::OnlineOrder.all.sample.must_be_kind_of Grocery::Order

      Grocery::OnlineOrder.all.length.must_equal 100

      @online_order.customer.must_be_instance_of Grocery::Customer
      @online_order.must_respond_to :status
      @online_order.status.must_equal :complete

      Grocery::OnlineOrder.all.first.id.must_equal 1
      Grocery::OnlineOrder.all.first.status.must_equal :complete

      Grocery::OnlineOrder.all.last.id.must_equal 100
      Grocery::OnlineOrder.all.last.status.must_equal :pending
    end
  end

  describe "OnlineOrder.find_by_customer" do
    it "Returns an array of online orders for a specific customer ID" do
      Grocery::OnlineOrder.find_by_customer(2).must_be_instance_of Array
      #Grocery::OnlineOrder.find_by_customer(2).sample.must_be_instance_of Grocery::OnlineOrder

    end
  end
end
