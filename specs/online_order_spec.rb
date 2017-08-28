require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'

require_relative '../lib/online_order'
require_relative '../lib/order'

# Because an OnlineOrder is a kind of Order, and we've
# already tested a bunch of functionality on Order,
# we effectively get all that testing for free! Here we'll
# only test things that are different.

describe "OnlineOrder" do
  describe "#initialize" do
    it "Is a kind of Order" do
      # Instatiate your OnlineOrder here
      id = 4
      products = {}
      customer_id = 2
      status = :shipped
      online_order = Grocery::OnlineOrder.new(id, products, customer_id, status = :pending)

      online_order.must_be_kind_of Grocery::Order

    end

    it "Can access Customer object" do
      id = 4
      products = {}
      customer_id = 2
      status = :shipped
      online_order = Grocery::OnlineOrder.new(id, products, customer_id, status = :pending)

      online_order.customer_id.must_equal 2

    end

    it "Can access the online order status" do
      id = 4
      products = {}
      customer_id = 2
      status = :shipped
      online_order = Grocery::OnlineOrder.new(id, products, customer_id, status)

      online_order.status.must_equal :shipped
      online_order.status.must_be_kind_of Symbol
    end
  end

  describe "#total" do
    it "Adds a shipping fee" do
      products = { "banana" => 1.99, "cracker" => 3.00 }
      order = Grocery::OnlineOrder.new(3, products, 4, :pending)
      order.total.must_equal 14.99
    end

    it "Doesn't add a shipping fee if there are no products" do
      products = {}
      order = Grocery::OnlineOrder.new(3, products, 4, :pending)
      order.total.must_equal 0
      # proc {order.total }.must_raise ArgumentError
    end
  end

  describe "#add_product" do
    it "Does not permit action for processing, shipped or completed statuses" do
      products = { "banana" => 1.99, "cracker" => 3.00 }
      order = Grocery::OnlineOrder.new(3, products, 4, :processing)

      proc {order.add_product("raisins", 3.24) }.must_raise ArgumentError

      products = { "banana" => 1.99, "cracker" => 3.00 }
      order = Grocery::OnlineOrder.new(3, products, 4, :shipped)
      proc {order.add_product("raisins", 3.24) }.must_raise ArgumentError

      products = { "banana" => 1.99, "cracker" => 3.00 }
      order = Grocery::OnlineOrder.new(3, products, 4, :completed)
      proc {order.add_product("raisins", 3.24) }.must_raise ArgumentError


    end

    it "Permits action for pending and paid satuses" do
      products = { "banana" => 1.99, "cracker" => 3.00 }
      order = Grocery::OnlineOrder.new(3, products, 4, :pending)
      order.add_product("raisins", 3.24)

      products = { "banana" => 1.99, "cracker" => 3.00 }
      order = Grocery::OnlineOrder.new(3, products, 4, :paid)
      order.add_product("raisins", 3.24)

    end
  end

  describe "OnlineOrder.all" do

    it "Returns an array of all online orders" do
      order = Grocery::OnlineOrder.all

      order.must_be_instance_of Array
    end

    it "Returns an array where everything is an Order" do
      order = Grocery::OnlineOrder.all
      order.each do |line|
        line.must_be_instance_of Grocery::Order
      end
    end

    it "Creates the correct number of orders" do
      order = Grocery::OnlineOrder.all
      order.count.must_equal 100
    end

    it "Contains the status" do
      order = Grocery::OnlineOrder.all
      order.first.include?(order.status).must_equal true
    end

    it "Contains the customer" do
      order = Grocery::OnlineOrder.all
      order.first.include?(order.customer_id).must_equal true
    end
  end #onlineorder.all end

  describe "OnlineOrder.find_by_customer" do
    it "Returns an array of online orders for a specific customer ID" do
    end
  end #onlineorder.find_by_customer end
end
