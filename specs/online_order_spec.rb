require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'

require_relative '../lib/online_order'
require_relative '../lib/order'

describe "OnlineOrder" do
  describe "#initialize" do
    it "Is a kind of Order" do
      id = 234
      products = {}
      customer_id = 12
      online_order = Grocery::OnlineOrder.new(id, products, customer_id)
      online_order.must_be_kind_of Grocery::Order
    end

    it "Can access Customer object" do
      id = 234
      products = {}
      customer_id = 12
      online_order = Grocery::OnlineOrder.new(id, products, customer_id)
      online_order.customer_id.must_equal 12
    end

    it "Can access the online order status" do
      id = 234
      products = {}
      customer_id = 12
      online_order = Grocery::OnlineOrder.new(id, products, customer_id)
      online_order.status.must_equal :pending
    end
  end

  describe "#total" do
    it "Adds a shipping fee" do
      id = 234
      products = {"banana" => 10}
      customer_id = 12
      online_order = Grocery::OnlineOrder.new(id, products, customer_id)
      sum = products.values.inject(0, :+)
      expected_total = sum + (sum * 0.075).round(2)
      online_order.total.must_equal expected_total + 10
    end

    it "Doesn't add a shipping fee if there are no products" do
      id = 234
      products = {}
      customer_id = 12
      online_order = Grocery::OnlineOrder.new(id, products, customer_id)
      online_order.total.must_equal 0
    end
  end

  describe "#add_product" do
    it "Does not permit action for processing, shipped or completed statuses" do
      shipped_products = { "banana" => 1.99, "cracker" => 3.00 }
      processing_products = { "banana" => 1.99, "cracker" => 3.00 }
      complete_products = { "banana" => 1.99, "cracker" => 3.00 }

      online_order_shipped = Grocery::OnlineOrder.new(1337, shipped_products, 34, :shipped)
      online_order_processing = Grocery::OnlineOrder.new(1337, processing_products, 34, :processing)
      online_order_completed = Grocery::OnlineOrder.new(1337, complete_products, 34, :complete)

      proc {online_order_shipped.add_product("sandwich", 4.25)}.must_raise ArgumentError
      proc {online_order_processing.add_product("sandwich", 4.25)}.must_raise ArgumentError
      proc {online_order_completed.add_product("sandwich", 4.25)}.must_raise ArgumentError
    end

    it "Permits action for pending and paid statuses" do
      pending_products = { "banana" => 1.99, "cracker" => 3.00 }
      paid_products = { "banana" => 1.99, "cracker" => 3.00 }

      online_order_pending = Grocery::OnlineOrder.new(1337, pending_products, 34)
      online_order_paid = Grocery::OnlineOrder.new(1337, paid_products, 34, :paid)

      online_order_pending.add_product("sandwich", 4.25).must_equal true

      online_order_paid.add_product("sandwich", 4.25).must_equal true
    end
  end

  describe "OnlineOrder.all" do
    it "Returns an array of all online orders" do
      Grocery::OnlineOrder.all("support/online_orders.csv").must_be_kind_of Array
    end

    it "Everything in the array is an Order" do
      Grocery::OnlineOrder.all("support/online_orders.csv").each do |order|
        order.must_be_kind_of Grocery::OnlineOrder
      end
    end

    it "The number of orders is correct" do
      Grocery::OnlineOrder.all("support/online_orders.csv").length.must_equal 100
    end

    it "The customer is present" do
      Grocery::OnlineOrder.all("support/online_orders.csv").first. customer_id.must_equal 25

      Grocery::OnlineOrder.all("support/online_orders.csv").last. customer_id.must_equal 20
    end

    it "The status is present" do
      Grocery::OnlineOrder.all("support/online_orders.csv").first. status.must_equal :complete

      Grocery::OnlineOrder.all("support/online_orders.csv").last. status.must_equal :pending
    end

  end

  describe "OnlineOrder.find_by_customer" do
    it "Returns an array of online orders for a specific customer ID" do
      Grocery::OnlineOrder.find_by_customer(1, "support/online_orders.csv").must_be_kind_of Array
    end

    it "The number of orders is correct" do
      Grocery::OnlineOrder.find_by_customer(1, "support/online_orders.csv").length.must_equal 1
    end

    it "Raises an error for a customer that doesn't exist" do
      proc {Grocery::OnlineOrder.find_by_customer(100000, "support/online_orders.csv")}.must_raise ArgumentError
    end
  end
end
