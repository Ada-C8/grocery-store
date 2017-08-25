require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'

require_relative '../lib/online_order'

describe "OnlineOrder" do
  describe "#initialize" do
    it "Is a kind of Order" do
      products = {"carrots" => 1.99, "salad mix" => 3.99}
      online_order = Grocery::OnlineOrder.new(200, products, "1", :complete)
      result = online_order.is_a? Grocery::Order
      result.must_equal true
    end

    it "Can access Customer object" do
      products = {"carrots" => 1.99, "salad mix" => 3.99}
      online_order = Grocery::OnlineOrder.new(200, products, "1", :complete)
      online_order.must_respond_to :customer
      actual_customer = online_order.customer
      result = actual_customer.is_a? Grocery::Customer
      result.must_equal true

    end

    it "Can access the online order status" do
      products = {"carrots" => 1.99, "salad mix" => 3.99}
      online_order = Grocery::OnlineOrder.new(200, products, "1", :complete)
      online_order.must_respond_to :status

      actual_status = online_order.status
      result = [:pending, :paid, :shipped, :complete].include? actual_status
      result.must_equal true
    end
  end

  describe "#total" do
    it "Adds a shipping fee" do
      products = {"carrots" => 1.99, "salad mix" => 3.99}
      regular_order = Grocery::Order.new(200, products)
      online_order = Grocery::OnlineOrder.new(200, products, "1", :complete)
      regular_total = regular_order.total
      expected_online_total = regular_total + 10
      online_order.total.must_equal expected_online_total
    end

    it "Doesn't add a shipping fee if there are no products" do
      online_order = Grocery::OnlineOrder.new(200,"1",:complete)
      expected_online_total = 0
      actual_online_total = online_order.total
      actual_online_total.must_equal expected_online_total
    end
  end

  describe "#add_product" do
    it "Does not permit action for processing, shipped or complete statuses" do
      products = {"carrots" => 1.99, "salad mix" => 3.99}
      complete_online_order = Grocery::OnlineOrder.new(200, products,"1", :complete)
      shipped_online_order = Grocery::OnlineOrder.new(201, products,"1", :shipped)
      processing_online_order = Grocery::OnlineOrder.new(202, products,"1",:processing)

      proc {complete_online_order.add_product("almond butt", 7.99)}.must_raise ArgumentError
      proc {shipped_online_order.add_product("almond butt", 8.99)}.must_raise ArgumentError
      proc {processing_online_order.add_product("almond butt", 9.99)}.must_raise ArgumentError
    end

    it "Permits action for pending and paid satuses" do
      products = {"carrots" => 1.99, "salad mix" => 3.99}
      pending_online_order = Grocery::OnlineOrder.new(200, products, "1", :pending)
      paid_online_order = Grocery::OnlineOrder.new(201, products, "1", :paid)
      pending_online_order.add_product("almond butt", 4.99)
      paid_online_order.add_product("almond butt", 3.99)
      expected_count = 3

      pending_online_order.products.count.must_equal expected_count
      paid_online_order.products.count.must_equal expected_count
    end
  end

  describe "OnlineOrder.all" do
    it "Returns an array" do
      result = Grocery::OnlineOrder.all
      result.must_be_instance_of Array
    end

    it "Everything in the array is an Order" do
      result = Grocery::OnlineOrder.all
      result.each do |element|
        element.must_be_instance_of Grocery::OnlineOrder
        result = element.is_a? Grocery::Order
        result.must_equal true
      end
    end

    it "The number of order is correct" do
      result = Grocery::OnlineOrder.all
      result.length.must_equal 100
    end

    it "The customer is present" do
      result = Grocery::OnlineOrder.all
      result[0].customer.must_be_instance_of Grocery::Customer
      result[10].customer.must_be_instance_of Grocery::Customer
      result[-1].customer.must_be_instance_of Grocery::Customer
    end

    it "The status is present" do
      result = Grocery::OnlineOrder.all
      [:pending, :paid, :shipped, :complete].include? result[0].status
      [:pending, :paid, :shipped, :complete].include? result[10].status
      [:pending, :paid, :shipped, :complete].include? result[-1].status
    end
  end

  describe "OnlineOrder.find" do
    it "Returns an order" do
      result = Grocery::OnlineOrder.find("1")
      result.must_be_instance_of Grocery::OnlineOrder
    end

    it "Returns an error if Order does not exist" do
      proc {Grocery::OnlineOrder.find(1000000)}.must_raise ArgumentError
    end
  end

  describe "OnlineOrder.find_by_customer" do
    it "Returns an array" do
      result = Grocery::OnlineOrder.find_by_customer("1")
      result.must_be_instance_of Array
    end

    it "Returns an array of online orders for a specific customer ID" do
      result = Grocery::OnlineOrder.find_by_customer("1")
      result.length.must_be :>, 0
    end

    it "Returns an error if customer doesn't exist" do
      proc {Grocery::OnlineOrder.find_by_customer("ksldjg")}.must_raise ArgumentError
    end
  end
end
