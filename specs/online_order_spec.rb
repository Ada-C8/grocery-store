require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require 'minitest/pride'
require 'pry'
require_relative '../lib/online_order'
require_relative '../lib/customer'
# TODO: uncomment the next line once you start wave 3
# require_relative '../lib/online_order'
# You may also need to require other classes here

# Because an OnlineOrder is a kind of Order, and we've
# already tested a bunch of functionality on Order,
# we effectively get all that testing for free! Here we'll
# only test things that are different.
describe "OnlineOrder" do
  before do
    @online_order_one = Grocery::OnlineOrder.new(1,{"Lobster" =>17.18, "Annatto seed" => 58.38, "Camomile" =>83.21}, 25,"complete")

    @online_order_two = Grocery::OnlineOrder.new(2,{}, 26,"pending")

    @customer_first = Grocery::Customer.new(25, "leonard.rogahn@hagenes.org", {address1: "71596 Eden Route" , city: "Connellymouth" , state: "LA", zip_code: "98872-9105" })

    @online_orders = Grocery::OnlineOrder.all
  end
  describe "#initialize" do
    it "Is a kind of Order" do
      @online_order_one.must_be_kind_of Grocery::Order
    end

    it "Can access Customer object" do
      @online_order_one.customer_id.must_equal @customer_first.customer_id
    end

    it "Can access the online order status, Order ID, products, and customer id" do
      @online_order_one.must_respond_to :status
      @online_order_one.must_respond_to :id
      @online_order_one.must_respond_to :customer_id
      @online_order_one.must_respond_to :products
    end
  end

  describe "#total" do
    it "Adds a shipping fee" do
      @online_order_one.total.must_equal 180.68
    end

    it "Doesn't add a shipping fee if there are no products" do
      @online_order_two.total.must_equal 0
    end
  end

  describe "#add_product" do
    it "Does not permit action for processing, shipped or completed statuses" do
      proc{Grocery::OnlineOrder.new(1,{"Lobster" =>17.18, "Annatto seed" => 58.38, "Camomile" =>83.21}, 25,"processing").add_product("Macadamia Nut",79.19)}.must_raise ArgumentError

      proc{Grocery::OnlineOrder.new(1,{"Lobster" =>17.18, "Annatto seed" => 58.38, "Camomile" =>83.21}, 25,"shipped").add_product("Macadamia Nut",79.19)}.must_raise ArgumentError

      proc{Grocery::OnlineOrder.new(1,{"Lobster" =>17.18, "Annatto seed" => 58.38, "Camomile" =>83.21}, 25,"complete").add_product("Macadamia Nut",79.19)}.must_raise ArgumentError
    end

    it "Permits action for pending and paid satuses" do
      #double check this stuff
      # original = @online_order_one.products.length

      @online_order_two.add_product("Macadamia Nut",79.19)
      after = @online_order_two.products.length
      after.must_equal 1

      tests = Grocery::OnlineOrder.new(1,{"Lobster" =>17.18, "Annatto seed" => 58.38, "Camomile" =>83.21}, 25)

      tests.status

      after = Grocery::OnlineOrder.new(1,{"Lobster" =>17.18, "Annatto seed" => 58.38, "Camomile" =>83.21}, 25,"paid")

      after.add_product("Macadamia Nut",79.19)
      after.products.length.must_equal 4
    end
  end


  describe "OnlineOrder.all" do

    it "Everything in the array is an Order" do
      @online_orders.each do |order|
        order.must_be_kind_of Grocery::OnlineOrder
      end
    end

    it "OnlineOrder.all returns an array" do
      @online_orders.must_be_kind_of Array
    end

    it "The number of online orders is correct (100)" do
      @online_orders.length.must_equal 100
    end

    #The wording on this prompt is vauge. I'm not sure this test is targeted at extracting the approptiate information
    it "The customer is present - Raises and error if the customer ID doesn't exist" do
      @online_orders.each do |order|
        order.customer_id.wont_be_empty
      end
    end

    it "The status is present - all users have a status AKA default parameter value works" do
      @online_orders.each do |order|
        order.status.wont_be_empty
      end
    end
  end

  xdescribe "OnlineOrder.find_by_customer" do
    it "Returns an array of online orders for a specific customer ID" do
      # TODO: Your test code here!
    end
  end #end of describe "OnlineOrder.find_by_customer"
end #end of describe "OnlineOrder"
