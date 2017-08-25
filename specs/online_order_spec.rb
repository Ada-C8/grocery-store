require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '/Users/kimberley/ada/week-three/grocery-store/lib/online-order.rb'
require_relative '../lib/customer'

describe "OnlineOrder" do
  describe "#initialize" do
    it "Is a kind of Order" do
      online_order = Grocery::OnlineOrder.new(53, {"banana" => 1.99, "cracker" => 3.00}, 24, status: :paid)

      online_order.must_be_kind_of Grocery::Order
      online_order.must_be_instance_of Grocery::OnlineOrder
    end

    it "Can access Customer object" do
      online_order = Grocery::OnlineOrder.new(53, {"banana" => 1.99, "cracker" => 3.00}, 24, status: :paid)

      online_order.customer.must_be_instance_of Grocery::Customer
    end

    it "Can access the online order status" do
      online_order = Grocery::OnlineOrder.new(53, {"banana" => 1.99, "cracker" => 3.00}, 24, status: :paid)

      online_order.must_respond_to :status
      online_order.status.must_be_instance_of Symbol
      online_order.status.must_equal :paid
    end
  end

  describe "#total" do
    it "Adds a shipping fee" do
      online_order = Grocery::OnlineOrder.new(53, {"banana" => 1.99, "cracker" => 3.00}, 24, status: :paid)

      test_total = (4.99 + (4.99 * 0.075).round(2)) + 10
      online_order.total.must_equal test_total
    end

    it "Doesn't add a shipping fee if there are no products" do
      online_order = Grocery::OnlineOrder.new(53, {}, 24, status: :paid)

      online_order.total.must_equal 0
    end
  end

  describe "#add_product" do
    it "Does not permit action for processing, shipped or completed statuses" do
      online_order = Grocery::OnlineOrder.new(53, {"banana" => 1.99, "cracker" => 3.00}, 24, status: :processing)
      proc {online_order.add_product("salmon", 8.99)}.must_raise ArgumentError

      online_order = Grocery::OnlineOrder.new(53, {"banana" => 1.99, "cracker" => 3.00}, 24, status: :shipped)
      proc {online_order.add_product("salmon", 8.99)}.must_raise ArgumentError

      online_order = Grocery::OnlineOrder.new(53, {"banana" => 1.99, "cracker" => 3.00}, 24, status: :completed)
      proc {online_order.add_product("salmon", 8.99)}.must_raise ArgumentError
    end

    it "Permits action for pending and paid satuses" do
      online_order = Grocery::OnlineOrder.new(53, {"banana" => 1.99, "cracker" => 3.00}, 24, status: :paid)

      online_order.add_product("salmon", 8.99)
      online_order.products.count.must_equal 3

      online_order = Grocery::OnlineOrder.new(53, {"banana" => 1.99, "cracker" => 3.00}, 24, status: :pending)

      online_order.add_product("salmon", 8.99)
      online_order.products.count.must_equal 3
    end
  end

  describe "OnlineOrder.all" do
    it "Returns an array of all online orders" do
      Grocery::OnlineOrder.all.must_be_instance_of Array

      Grocery::OnlineOrder.all[17].must_be_instance_of Grocery::OnlineOrder
    end

    it "each object in the array is an order" do
      order = Grocery::OnlineOrder.all[1]
      order.must_be_instance_of Grocery::OnlineOrder

      order = Grocery::OnlineOrder.all[99]
      order.must_be_instance_of Grocery::OnlineOrder

      order = Grocery::OnlineOrder.all[12]
      order.must_be_instance_of Grocery::OnlineOrder
    end

    it "has correct order status" do
      order = Grocery::OnlineOrder.all[0]
      order.status.must_equal :complete

      order = Grocery::OnlineOrder.all[99]
      order.status.must_equal :pending

      Grocery::OnlineOrder.all[18].status.must_be_instance_of Symbol
    end

    it "The number of online orders is correct" do
      Grocery::OnlineOrder.all.count.must_equal 100
    end

  end
end

describe "OnlineOrder.find_by_customer" do
  it "Returns an array of online orders for a specific customer  ID" do
    Grocery::OnlineOrder.find_by_customer(26).must_be_instance_of Array

    orders = Grocery::OnlineOrder.find_by_customer(26)
    orders[0].must_be_instance_of Grocery::OnlineOrder
  end

  it "Raises an error for a customer that doesn't exist" do
    proc {Grocery::OnlineOrder.find_by_customer(1000)}.must_raise ArgumentError

    proc {Grocery::OnlineOrder.find_by_customer(-3)}.must_raise ArgumentError

    proc {Grocery::OnlineOrder.find_by_customer(0)}.must_raise ArgumentError
  end
end
