require_relative 'spec_helper'
require_relative '../lib/online_order'
require_relative '../lib/order'
require_relative '../lib/customer'
# You may also need to require other classes here

# Because an OnlineOrder is a kind of Order, and we've
# already tested a bunch of functionality on Order,
# we effectively get all that testing for free! Here we'll
# only test things that are different.

# test_customer = Grocery::Customer.new(1,"email@email.com","100 Test St", "Test City", "TN", "19294")
online_order_list = "./support/online_orders.csv"
customer_list = "./support/customers.csv"
# test_customer = Grocery::Customer.find(1, Grocery::Customer.all(customer_list))

describe "OnlineOrder" do
  before do
    @test_order = Grocery::Online_Order.all(online_order_list,customer_list)[0]
  end
  describe "#initialize" do

    it "Is a kind of Order" do
      # Check that an OnlineOrder is in fact a kind of Order

      # Instatiate your OnlineOrder here <- (I did it up above instead)
      @test_order.must_be_kind_of Grocery::Order
    end

    it "Has products in a hash" do
      @test_order.products.must_be_kind_of Hash
    end

    it "Can access Customer object" do
      @test_order.customer.must_be_kind_of Grocery::Customer
    end

    it "Can access the online order status" do
      @test_order.status.must_be_kind_of Symbol
      [:pending, :paid, :processing, :shipped, :complete].include?(@test_order.status).must_equal true
    end
  end

  describe "#total" do
    @test_order = Grocery::Online_Order.all(online_order_list,customer_list)[0]

    it "Adds a shipping fee" do
      (@test_order.total).must_equal 180.68
    end

    it "Doesn't add a shipping fee if there are no products" do
      empty_order = Grocery::Online_Order.new(1,[],Grocery::Customer.new(1,2,3,4,5,6))
      empty_order.total.must_equal 0
    end
  end

  describe "#set_status" do
    it "can change the status" do
      @test_order.set_status(:shipped)
      @test_order.status.must_equal :shipped
    end

    it "cannot change the status to an invalid status" do
      proc{@test_order.set_status(:juice)}.must_raise Exception
    end
  end

  describe "#add_product" do
    @test_order = Grocery::Online_Order.all(online_order_list,customer_list)[0]

    it "Does not permit action for processing, shipped or completed statuses" do
      @test_order.set_status(:shipped)
      proc{@test_order.add_product("testing",3)}.must_raise Exception

      @test_order.set_status(:processing)
      proc{@test_order.add_product("testing",3)}.must_raise Exception

      @test_order.set_status(:complete)
      proc{@test_order.add_product("testing",3)}.must_raise Exception
    end

    it "Permits action for pending and paid statuses" do
      @test_order.set_status(:pending)
      @test_order.add_product("testing",3)

      @test_order.set_status(:paid)
      @test_order.add_product("testing more", 10)
    end
  end

  describe "OnlineOrder.all" do

    test_orders = Grocery::Online_Order.all(online_order_list,customer_list)

    it "Returns an array of all online orders" do
      # TODO: Your test code here!
      # Useful checks might include:
      #   - OnlineOrder.all returns an array
      #   - Everything in the array is an Order
      #   - The number of orders is correct
      #   - The customer is present
      #   - The status is present
      # Feel free to split this into multiple tests if needed

      test_orders.must_be_kind_of Array

      test_orders.length.must_equal 100

      test_orders.each do |order|
        order.must_be_kind_of Grocery::Online_Order
        order.customer.must_be_kind_of Grocery::Customer
        # puts order.products
      end

    end
  end

  describe "OnlineOrder.find" do
    # This didn't need to be modified from the parent class ¯\_(ツ)_/¯
    test_orders = Grocery::Online_Order.all(online_order_list,customer_list)
    it "Returns an order, by ID, from given list" do
      Grocery::Online_Order.find(1, test_orders).must_equal test_orders[0]
      Grocery::Online_Order.find(100, test_orders).must_equal test_orders[99]
    end
  end

  describe "OnlineOrder.find_by_customer" do

    test_orders = Grocery::Online_Order.all(online_order_list,customer_list)

    it "Returns an array of online orders for a specific customer ID" do
      Grocery::Online_Order.find_by_customer(10, test_orders).must_be_kind_of Array
      Grocery::Online_Order.find_by_customer(25, test_orders).length.must_equal 6

      proc{Grocery::Online_Order.find_by_customer(2500, test_orders)}.must_raise RangeError

      Grocery::Online_Order.find_by_customer(14, test_orders).each do |order|
        order.must_be_kind_of Grocery::Online_Order
        order.customer.id.must_equal 14
      end
    end
  end
end
