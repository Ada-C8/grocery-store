require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/online_order'
require_relative '../lib/customer'
require 'pry'
# You may also need to require other classes here

# Because an OnlineOrder is a kind of Order, and we've
# already tested a bunch of functionality on Order,
# we effectively get all that testing for free! Here we'll
# only test things that are different.

describe "OnlineOrder" do
  before do
    @test_order = Grocery::OnlineOrder.new(1, {"Lobster" => 17.18, "Annatto seed" => 58.38, "Camomile" => 83.21}, 25, "complete")

    @test_order2 = Grocery::OnlineOrder.new(2, {}, 26, "processing")


    @customer_first = Grocery::Customer.new(25, "leonard.rogahn@hagenes.org", {address: "71596 Eden Route", city: "Connellymouth", state: "LA", zipcode: "98872-9105"})

    @all_cust = Grocery::OnlineOrder.all
  end

  describe "#initialize" do
    it "Is a kind of Order" do
      # Check that an OnlineOrder is in fact a kind of Order
      # Instatiate your OnlineOrder here
      @test_order.must_be_kind_of Grocery::Order
    end

    it "Can access Customer object" do
      @test_order.customer_id.must_equal @customer_first.customer_id
    end

    it "Can access the online order status" do
      @test_order.must_respond_to :status
    end
  end

  describe "#total" do
    it "Adds a shipping fee" do
      @test_order.total.must_equal 180.68
    end

    it "Doesn't add a shipping fee if there are no products" do
      @test_order2.total.must_equal 0
    end
  end

  describe "#add_product" do
    it "Does not permit action for completed statuses" do
      proc{@test_order.add_product("Macadamia Nut", 79.19)}.must_raise ArgumentError
    end

    it "Does not permit action for shipped statuses" do
      proc{Grocery::OnlineOrder.new(5, {"Lobster" => 17.18}, 26, "shipped").add_product("Macadamia Nut", 79.19)}.must_raise ArgumentError
    end

    it "Does not permit action for processing statuses" do
      proc{Grocery::OnlineOrder.new(5, {"Lobster" => 17.18}, 26, "processing").add_product("Macadamia Nut", 79.19)}.must_raise ArgumentError
    end

    it "Permits action for pending status" do
      Grocery::OnlineOrder.new(5, {"Lobster" => 17.18}, 26, "pending").add_product("Macadamia Nut", 79.19).must_equal true
      # try product length equals 2?
    end

    it "Permits action for paid status" do
      Grocery::OnlineOrder.new(5, {"Lobster" => 17.18}, 26, "paid").add_product("Macadamia Nut", 79.19).must_equal true
    end
  end

  describe "OnlineOrder.all" do
    it "Returns an array of all online orders" do
      # before do
      #   @orders = Grocery::Order.all
      # end
      @all_cust.must_be_kind_of Array
    end # array

    it "The number of orders is correct" do
      @all_cust.length.must_equal 100
    end # num of orders

    it "order has customer id" do
      @all_cust[0].customer_id.must_equal 25
      @all_cust.last.id.must_equal 100
    end #customer id

    it ".all holds an order status" do
      @all_cust[0].status.must_equal :complete

    end #status

  end # .all method

  describe "OnlineOrder.find_by_customer" do
    it "Returns an array of online orders for a specific customer ID" do
      Grocery::OnlineOrder.find_by_customer(2).must_be_instance_of Array
      Grocery::OnlineOrder.find_by_customer(2).sample.must_be_instance_of Grocery::OnlineOrder
      Grocery::OnlineOrder.find_by_customer(2).sample.customer_id.must_equal 2

    end
  end
end
