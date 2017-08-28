require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/online_order'

# TODO: uncomment the next line once you start wave 3
# require_relative '../lib/online_order'
# You may also need to require other classes here

# Because an OnlineOrder is a kind of Order, and we've
# already tested a bunch of functionality on Order,
# we effectively get all that testing for free! Here we'll
# only test things that are different.

describe "OnlineOrder" do
  before do
    @online_order = Grocery::OnlineOrder.new(111, {"stuff" => 3.41}, 3, :complete)
    @online_order3 = Grocery::OnlineOrder.new(104, {"more stuff" => 3.22}, 5)
    @online_order4 = Grocery::OnlineOrder.new(111, {"stuff" => 3.41}, 3, :shipped)
    @online_order5 = Grocery::OnlineOrder.new(111, {"stuff" => 3.41}, 3, :processing)
    @online_order6 = Grocery::OnlineOrder.new(111, {"stuff" => 3.41}, 3, :paid)
    @online_order7 = Grocery::OnlineOrder.new(111, {"stuff" => 3.41}, 3, :pending)
  end
  describe "#initialize" do
    it "Is a kind of Order" do
      @online_order.must_be_kind_of Grocery::Order
    end

    it "Can access Customer object" do
      @online_order.customer.must_be_instance_of Grocery::Customer
    end

    it "Can access the online order status" do
      @online_order.status.must_be_instance_of Symbol
      @online_order.status.must_equal :complete
      @online_order3.status.must_equal :pending

    end
  end

  describe "#total" do
    it "Adds a shipping fee" do
      @online_order.total.must_equal (3.41*1.075 + 10).round(2)
      @online_order3.total.must_equal (3.22*1.075 + 10).round(2)
    end

    it "Doesn't add a shipping fee if there are no products" do
      @online_order2 = Grocery::OnlineOrder.new(111, {}, 3, :complete)
      @online_order2.total.must_equal 0

    end
  end

  describe "#add_product" do
    it "Does not permit action for processing, shipped or completed statuses" do
      proc {@online_order.add_product("hummus", 2.41)}.must_raise ArgumentError
      proc {@online_order4.add_product("hummus", 2.41)}.must_raise ArgumentError
      proc {@online_order5.add_product("hummus", 2.41)}.must_raise ArgumentError
    end

    it "Permits action for pending and paid satuses" do
      @online_order6.must_respond_to :add_product
      @online_order7.must_respond_to :add_product

      original_list = @online_order7.products_list

      @online_order7.add_product("hummus", 2.41)
      @online_order7.products_list.wont_match original_list
    end
  end

  describe "OnlineOrder.all" do
    it "Returns an array of all online orders" do
      # TODO: Your test code here!
      Grocery::OnlineOrder.all.must_be_instance_of Array
      Grocery::OnlineOrder.all.sample.must_be_instance_of Grocery::OnlineOrder
      Grocery::OnlineOrder.all.sample.must_be_kind_of Grocery::Order

      Grocery::OnlineOrder.all.length.must_equal 100

      @online_order.customer.must_be_instance_of Grocery::Customer
      @online_order.must_respond_to :status
      @online_order.status.must_equal :complete

      Grocery::OnlineOrder.all.first.id.must_equal 1
      Grocery::OnlineOrder.all.first.status.must_equal :complete

      Grocery::OnlineOrder.all.last.id.must_equal 100
      Grocery::OnlineOrder.all.last.status.must_equal :pending
    end
  end

  describe "OnlineOrder.find" do
    it "must find an online order matching the specifications for that ID" do
      Grocery::OnlineOrder.find(1).status.must_equal :complete
      Grocery::OnlineOrder.find(100).status.must_equal :pending
    end
  end

  describe "OnlineOrder.find_by_customer" do
    it "Returns an array of online orders for a specific customer ID" do
      Grocery::OnlineOrder.find_by_customer(12).must_be_instance_of Array
      Grocery::OnlineOrder.find_by_customer(12).sample.must_be_instance_of Grocery::OnlineOrder

      Grocery::OnlineOrder.find_by_customer(12).length.must_equal 7


      proc {Grocery::OnlineOrder.find_by_customer("A")}.must_raise ArgumentError
      proc {Grocery::OnlineOrder.find_by_customer(-2)}.must_raise ArgumentError
      proc {Grocery::OnlineOrder.find_by_customer(400)}.must_raise ArgumentError
    end
  end
end
