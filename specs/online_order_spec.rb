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
    end

    it "Can access Customer object" do
      online_order = Grocery::OnlineOrder.new(53, {"banana" => 1.99, "cracker" => 3.00}, 24, status: :paid)
      online_order.customer.must_be_kind_of Grocery::Customer
    end

    it "Can access the online order status" do
    online_order = Grocery::OnlineOrder.new(53, {"banana" => 1.99, "cracker" => 3.00}, 24, status: :paid)
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
      online_order.add_product("salmon", 8.99)
      proc {online_order.add_product("salmon", 8.99)  }.must_raise ArgumentError

      online_order = Grocery::OnlineOrder.new(53, {"banana" => 1.99, "cracker" => 3.00}, 24, status: :shipped)
      online_order.add_product("salmon", 8.99)
      proc {online_order.add_product("salmon", 8.99)  }.must_raise ArgumentError

      online_order = Grocery::OnlineOrder.new(53, {"banana" => 1.99, "cracker" => 3.00}, 24, status: :completed)
      online_order.add_product("salmon", 8.99)
      proc {online_order.add_product("salmon", 8.99)  }.must_raise ArgumentError
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
