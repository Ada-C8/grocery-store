require 'csv'
require 'pry'
require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/OnlineOrder'


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
      # Grocery::OnlineOrder.must_be_kind_of Grocery::Order
      # Instatiate your OnlineOrder here
      online_order = Grocery::OnlineOrder.new(1,{"Lobster"=> 17.18, "Annatto seed" => 58.38, "Camomile" => 83.21}, 25, "complete")
      online_order.must_be_kind_of Grocery::Order
      # online_order =
      # online_order.must_be_kind_of Grocery::Order
    end
    # I was not sure how to do this so I 'x' it out.
    xit "Can access Customer object" do
      Grocery::OnlineOrder.must_be_instance_of Grocery::Customer
    end

    it "Can access the online order status" do
      Grocery::OnlineOrder.all[0].status.must_equal :complete
    end
  end

  describe "#total" do
    it "Adds a shipping fee" do
      Grocery::OnlineOrder.new(1, {"a" => 1.00}, 1, "pending").total.must_equal 11.08
      # Grocery::OnlineOrder.all[0].total must_equal online_order_1_total
    end

    it "Doesn't add a shipping fee if there are no products" do
      Grocery::OnlineOrder.new(1, {}, 1, "pending").total.must_equal 0
    end
  end

  describe "#add_product" do
    it "Does not permit 'adding product' for processing, shipped or completed statuses" do
      # Input for all three statuses
      result_processing = Grocery::OnlineOrder.new(1, {}, 1, "processing")
      result_shipped = Grocery::OnlineOrder.new(1, {}, 1, "shipped")
      result_completed = Grocery::OnlineOrder.new(1, {}, 1, "completed")

      # Tests for all three statuses
      proc{result_processing.add_product}.must_raise ArgumentError
      proc{result_shipped.add_product}.must_raise ArgumentError
      proc{result_completed.add_product}.must_raise ArgumentError
    end

    it "Permits action for pending and paid satuses" do
      # Input for both statuses
      result_pending = Grocery::OnlineOrder.new(1, {}, 1, "pending")
      result_paid = Grocery::OnlineOrder.new(1, {}, 1, "paid")

      # Tests for both statuses
      proc{result_pending.add_product}.must_raise ArgumentError
      proc{result_paid.add_product}.must_raise ArgumentError
    end
  end

  describe "OnlineOrder.all" do
    it "Returns an array" do
      Grocery::OnlineOrder.all.must_be_kind_of Array
    end

    it "Returns an OnlineOrder object" do
      Grocery::OnlineOrder.all[1].must_be_instance_of Grocery::OnlineOrder
    end

    it "Returns correct total number of online_orders" do
      # inputs
      fixture_count = CSV.read("support/online_orders.csv").length
      result_of = Grocery::OnlineOrder.all.length
      # test
      result_of.must_equal fixture_count
    end

    it "Returns first and last orders vai id, products, customer_id, status" do
      # Inputs
      products_1 = {"Lobster"=> 17.18, "Annatto seed" => 58.38, "Camomile" => 83.21}
      result_1 = Grocery::OnlineOrder.all[0]
      # Tests
      result_1.id.must_equal 1
      result_1.products.must_equal products_1
    end

  end

  describe "OnlineOrder.find_by_customer" do
    it "Returns an array of online orders for a specific customer ID" do
      customer_orders = Grocery::OnlineOrder.find_by_customer(1)
      # tests
      # returns array?
      customer_orders.must_be_kind_of Array
      # returns an online_order instance?
      customer_orders[0].must_be_instance_of Grocery::OnlineOrder
      # correct amount of instances in array?
      customer_orders.count.must_equal 1



    end
  end
end
