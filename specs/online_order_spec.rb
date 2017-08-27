require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'

require_relative '../lib/online_order'
require_relative '../lib/order'

describe "OnlineOrder" do

  before do
    @online_order = OnlineOrder.new(23, {"Cherries" => 90.16}, Grocery::Customer.find(1), "complete")
  end

  describe "#initialize" do
    it "Is a kind of Order" do
      @online_order.must_be_kind_of Grocery::Order
    end

    it "Can access Customer object" do
      @online_order.customer.must_be_kind_of Grocery::Customer
    end

    it "Can access the online order status" do
      @online_order.status.must_equal :complete
    end
  end

  describe "#total" do
    it "Adds a shipping fee" do
      @online_order.total.must_equal 106.92
    end

    it "Doesn't add a shipping fee if there are no products" do
      online_order_2 = OnlineOrder.new(23, {}, Grocery::Customer.find(1), "complete")

      online_order_2.total.must_equal 0
    end
  end

  describe "#add_product" do
    it "Does not permit action for processing, shipped or completed statuses and raises an argument error" do
      proc {@online_order.add_product("Bananas", 5.99)}.must_raise ArgumentError
    end

    it "Permits action for pending and paid satuses" do
      online_order_3 = OnlineOrder.new(23, {"Cherries" => 90.16}, Grocery::Customer.find(1), "pending")

      online_order_3.add_product("Kiwi", 1.50).must_equal true
    end
  end

  describe "OnlineOrder.all" do

    before do
      @online_order_all = OnlineOrder.all
    end

    it "Returns an array of all online orders" do
      @online_order_all.must_be_kind_of Array
    end

    it "Everything in the array is an Order" do
      @online_order_all[0].must_be_kind_of Grocery::Order
    end

    it "The number of orders is correct" do
      @online_order_all.length.must_equal 100
    end

    it "The customer is present" do
      @online_order_all[0].customer.must_be_kind_of Grocery::Customer
    end

    it "The status is present" do
      @online_order_all[0].status.must_equal :complete
    end
  end

  describe "OnlineOrder.find_by_customer" do
    it "Returns an array of online orders for a specific customer ID" do
      online_order_4 = OnlineOrder.find_by_customer(1)

      online_order_4.must_be_kind_of Array
      online_order_4[0].must_be_kind_of OnlineOrder
    end
  end
end
