require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'

require_relative '../lib/online_order'
require_relative '../lib/order'
require_relative '../lib/customer'
# You may also need to require other classes here

# Because an OnlineOrder is a kind of Order, and we've
# already tested a bunch of functionality on Order,
# we effectively get all that testing for free! Here we'll
# only test things that are different.

describe "OnlineOrder" do
  describe "#initialize" do
    it "Is a kind of Order" do
      # Check that an OnlineOrder is in fact a kind of Order
      id = 1313
      products = "burning sage"
      customer = Grocery::Customer.new(1001, "bad-dog@grounded.net", "123 Cat Paradise, Seattle, WA 98101")

      online_order = Grocery::OnlineOrder.new(id, products, customer)

      online_order.must_be_kind_of Grocery::Order
    end

    it "Can access Customer object" do
      id = 1313
      products = "burning sage"
      customer = Grocery::Customer.new(1001, "bad-dog@grounded.net", "123 Cat Paradise, Seattle, WA 98101")

      online_order = Grocery::OnlineOrder.new(id, products, customer)
      online_order.customer.email.must_equal "bad-dog@grounded.net"
    end

    it "Can access the online order status" do
      id = 1313
      products = "burning sage"
      customer = Grocery::Customer.new(1001, "bad-dog@grounded.net", "123 Cat Paradise, Seattle, WA 98101")

      online_order = Grocery::OnlineOrder.new(id, products, customer)
      online_order.status.must_equal :pending
    end
  end

  describe "#total" do
    it "Adds a shipping fee" do
      products = { "banana" => 1.99, "cracker" => 3.00 }
      order = Grocery::OnlineOrder.new(1337, products, "Finn")

      sum = products.values.inject(0, :+)
      expected_total = sum + (sum * 0.075).round(2) + 10

      order.total.must_equal expected_total
    end

    it "Doesn't add a shipping fee if there are no products" do
      products = {}
      order = Grocery::OnlineOrder.new(1337, products, "Finn")

      expected_total = 0 # no products plus no shipping
      order.total.must_equal expected_total
    end
  end

  describe "#add_product" do
    it "Does not permit action for processing, shipped or completed statuses" do
      order = Grocery::OnlineOrder.new(666, {1 => "cake",}, "Finn", :shipped)

      proc{order.add_product(1, "cake")}.must_raise ArgumentError
    end

    it "Permits action for pending and paid satuses" do
      order = Grocery::OnlineOrder.new(666, {"cat food" => 300}, "Finn", :pending)
      order.products.length.must_equal 1

      order.add_product("dog food", 300)
      order.products.length.must_equal 2
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
    it "Returns an Array when OnlineOrder.all is called" do
      Grocery::OnlineOrder.all.must_be_kind_of Array
    end

    it "Verifies the number of orders is correct" do
      total_orders = CSV.read("support/online_orders.csv", 'r').length
      Grocery::OnlineOrder.all.length.must_equal total_orders
    end

    it "Verifies everything in the Array is an Order" do
      Grocery::OnlineOrder.all.each do |order|
        order.must_be_kind_of Grocery::OnlineOrder
      end
    end

    it "Matches the ID, products, customer IDs, and status of the first and last orders with what's in the CSV file" do
      order = Grocery::OnlineOrder.all.first
      order.id.must_equal 1
      expected_order = {"Lobster"=>"17.18","Annatto seed"=>"58.38","Camomile"=>"83.21"}
      order.products.must_equal expected_order
      expected_customer = 25
      order.customer.must_equal expected_customer
      order.status.must_equal "complete"
    end
  end

  describe "OnlineOrder.find_by_customer" do
    it "Returns an array of online orders for a specific customer ID" do
      orders = Grocery::OnlineOrder.find_by_customer(30)
      orders.length.must_equal 3
    end
  end
end
