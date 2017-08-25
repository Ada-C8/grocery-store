require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'

require_relative '../lib/online_order'
# You may also need to require other classes here

describe "OnlineOrder" do
  describe "#initialize" do
    before do
      id = 1
      products = {"peas" => 2, "beer" => 8}
      customer = Grocery::Customer.new(34, "email", "address")
      status = :pending
      @online_order = Grocery::OnlineOrder.new(id, products, customer, status)
    end

    it "Is a kind of Order" do
      @online_order.must_be_kind_of Grocery::Order
    end

    it "Can access Customer object" do
      @online_order.customer.must_be_instance_of Grocery::Customer
    end

    it "Can access the online order status" do
      @online_order.status.must_be_instance_of Symbol
    end
  end

  describe "#total" do
    it "Adds a shipping fee" do
      products = {"peas" => 2, "beer" => 8}
      customer = Grocery::Customer.new(34, "email", "address")
      status = :pending
      online_order = Grocery::OnlineOrder.new(1, products, customer, status)

      offline_order = Grocery::Order.new(1, {"peas" => 2, "beer" => 8})
      online_order.total.must_equal offline_order.total + 10
    end

    it "Doesn't add a shipping fee if there are no products" do
      products = {}
      customer = Grocery::Customer.new(34, "email", "address")
      status = :pending
      online_order = Grocery::OnlineOrder.new(1, products, customer, status)

      online_order.total.must_equal 0
    end
  end

  describe "#add_product" do
    before do
      products = {}
      customer = Grocery::Customer.new(34, "email", "address")
      status = :pending
      @online_order = Grocery::OnlineOrder.new(1, products, customer, status)
    end

    it "Does not permit action for processing, shipped or completed statuses" do
      @online_order.status = :processing
      proc {@online_order.add_product("peas", 2)}.must_raise ArgumentError
      @online_order.status = :shipped
      proc {@online_order.add_product("peas", 2)}.must_raise ArgumentError
      @online_order.status = :complete
      proc {@online_order.add_product("peas", 2)}.must_raise ArgumentError
    end

    it "Permits action for pending and paid satuses" do
      @online_order.status = :pending
      @online_order.add_product("peas", 2).must_equal true
      @online_order.status = :paid
      @online_order.add_product("carrots", 4).must_equal true
    end
  end

  describe "OnlineOrder.all" do
    it "Returns an array of all online orders" do
      Grocery::OnlineOrder.all.must_be_instance_of Array
      Grocery::OnlineOrder.all.each do |element|
        element.must_be_instance_of Grocery::OnlineOrder
      end
      Grocery::OnlineOrder.all.length.must_equal 100
      Grocery::OnlineOrder.all[0].customer.must_equal 25
      Grocery::OnlineOrder.all[99].customer.must_equal 20
      Grocery::OnlineOrder.all[0].status.must_equal :complete
      Grocery::OnlineOrder.all[99].status.must_equal :pending
    end
  end

  describe "OnlineOrder.find" do
    it "can do find" do
      Grocery::OnlineOrder.find(1).id.must_equal 1
    end
  end

  xdescribe "OnlineOrder.find_by_customer" do
    it "Returns an array of online orders for a specific customer ID" do
      Grocery::OnlineOrder.find_by_customer()
      # TODO: Your test code here!
    end
  end
end
