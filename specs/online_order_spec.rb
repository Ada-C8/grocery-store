require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'

# TODO: uncomment the next line once you start wave 3
require_relative '../lib/online_order'
# You may also need to require other classes here

# Because an OnlineOrder is a kind of Order, and we've
# already tested a bunch of functionality on Order,
# we effectively get all that testing for free! Here we'll
# only test things that are different.

describe "OnlineOrder" do
  describe "#initialize" do
    it "Is a kind of Order" do
      # Check that an OnlineOrder is in fact a kind of Order

      # Instatiate your OnlineOrder here
      online_order = Grocery::OnlineOrder.all[0]
      online_order.must_be_instance_of Grocery::OnlineOrder
      online_order.must_be_kind_of Grocery::Order


    end

    it "Can access Customer object" do
      online_order = Grocery::OnlineOrder.all[0]
      online_order.must_respond_to :customer

      online_order.customer.must_be_instance_of Grocery::Customer
    end

    it "Can access the online order status" do
      online_order = Grocery::OnlineOrder.all[-1]
      online_order.must_respond_to :status

      [:pending, :processing, :shipped, :complete, :paid].must_include online_order.status
    end
  end

  describe "#total" do
    it "Adds a shipping fee" do
      # TODO: Your test code here!

      products = { "banana" => 1.99, "cracker" => 3.00 }
      order = Grocery::OnlineOrder.new(1337, products, 1, :pending)

      sum = products.values.inject(0, :+)
      expected_total = (sum + (sum * 0.075).round(2)) + 10

      order.total.must_equal expected_total
    end

    it "Doesn't add a shipping fee if there are no products" do
      # TODO: Your test code here!

      products = {}
      order = Grocery::OnlineOrder.new(1337, products, 1, :pending)

      order.total.must_equal 0

    end
  end

  describe "#add_product" do
    it "Does not permit action for processing, shipped or completed statuses" do
      # TODO: Your test code here!
      complete_online_order = Grocery::OnlineOrder.all[0]
      processing_online_order = Grocery::OnlineOrder.all[2]
      shipped_online_order = Grocery::OnlineOrder.all[4]

      [complete_online_order, processing_online_order,shipped_online_order].each do |online_order|

        proc { online_order.add_product("silly string", 4) }.must_raise ArgumentError
      end

    end

    it "Permits action for pending and paid satuses" do
      paid_online_order =  Grocery::OnlineOrder.all[1]
      pending_online_order = Grocery::OnlineOrder.all[5]

      [paid_online_order, pending_online_order].each do |online_order|
        before_count = online_order.products.count

        online_order.add_product("silly string", 4)
        after_count = online_order.products.count

        after_count.must_be :>, before_count

        online_order.products.keys.must_include "silly string"
        online_order.products["silly string"].must_equal 4
      end
      
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

      Grocery::OnlineOrder.all.must_be_kind_of Array

      Grocery::OnlineOrder.all.each do |online_ord|
        online_ord.must_be_kind_of Grocery::OnlineOrder
      end
    end


  end

  xdescribe "OnlineOrder.find_by_customer" do
    it "Returns an array of online orders for a specific customer ID" do
      # TODO: Your test code here!
    end
  end

end
