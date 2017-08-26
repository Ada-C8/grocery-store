require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'

# TODO: uncomment the next line once you start wave 3
require_relative '../lib/online_order'
require_relative '../lib/order'
require_relative '../lib/customer'

describe "OnlineOrder" do
  describe "#initialize" do
    it "Is a kind of Order" do
      # Check that an OnlineOrder is in fact a kind of Order
      order = "order"
      customer = "customer"
      status = "paid"
      online_order = OnlineOrder.new(order, customer, status)
      online_order.must_be_kind_of Grocery::Order
      online_order.must_be_instance_of OnlineOrder
      online_order.must_respond_to :customer
      online_order.must_respond_to :status
      online_order.must_respond_to :order
    end

    it "Status is stored as a symbol" do
      # check that status is symbol
      status = "paid"
      order = "order"
      customer = "customer"
      online_order = OnlineOrder.new(order, customer, status)
      online_order.status.must_be_kind_of Symbol
    end

    it "Defualt status is pending" do
      # check that defuakt status is :pending
      order = "order"
      customer = "customer"
      online_order = OnlineOrder.new(order, customer)
      online_order.status.must_equal :pending
    end


    it "Can access Customer object" do
      # TODO: Your test code here!
      OnlineOrder.all[99].customer.must_be_instance_of Grocery::Customer
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
      #
      # products = { "banana" => 1.99, "cracker" => 3.00 }
      # order = Grocery::Order.new(1337, products)
      #
      # order.add_product("sandwich", 4.25)
      # order.products.include?("sandwich").must_equal true
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
    it "Can access the online order status" do
      # ensure status for first and last online orders are correct
      OnlineOrder.all[0].status.must_equal :complete
      OnlineOrder.all[99].status.must_equal :pending
    end

  end

  describe "OnlineOrder.find_by_customer" do
    it "Returns an array of online orders for a specific customer ID" do
      # ensures that online order returns an array with correct orders for customer
      # customer 25 should have 6 orders
      OnlineOrder.find_by_customer(25).length.must_equal 6
    end
  end
end
