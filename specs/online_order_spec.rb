require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'

# TODO: uncomment the next line once you start wave 3
require_relative '../lib/online_orders'
# You may also need to require other classes here

# Because an OnlineOrder is a kind of Order, and we've
# already tested a bunch of functionality on Order,
# we effectively get all that testing for free! Here we'll
# only test things that are different.

describe "OnlineOrder" do

  before do
    @customer = Grocery::Customer.all
    @all = Grocery::OnlineOrder.all
  end

  describe "#initialize" do
    it "Is a kind of Order" do
      # Check that an OnlineOrder is in fact a kind of Order

      #Instatiate your OnlineOrder here
      id = 1337
      products = { "banana" => 1.99, "cracker" => 3.00, "sandwich" => 4.25 }
      online_order = Grocery::OnlineOrder.new(id,products,:paid,14)
      online_order.must_be_kind_of Grocery::OnlineOrder
    end

    it "Can access Customer object" do
      # TODO: Your test code here!
      @customer.must_be_instance_of Array
      @customer[5].email.must_equal "florence@pollich.info"
    end

    it "Can access the online order status" do
      # TODO: Your test code here!
      @all[10].status.must_be_instance_of Symbol
      @all[18].status.must_equal :processing
    end
  end

  describe "#total" do
    it "Adds a shipping fee" do
      # TODO: Your test code here!
      Grocery::OnlineOrder.find(30).total.must_be_instance_of Float
      @all[11].total.must_equal 153.53
    end

    it "Doesn't add a shipping fee if there are no products" do
      # TODO: Your test code here!
      online_order = Grocery::OnlineOrder.new(1337,{},:paid,14)
      online_order.total.must_equal 0
    end
  end

  describe "#add_product" do
    it "Does not permit action for processing, shipped or completed statuses" do
      # TODO: Your test code here!
      @all[18].status.must_equal :processing
      proc {@all[18].add_product("name", 34.34)}.must_raise ArgumentError
    end

    it "Permits action for pending and paid satuses" do
      # TODO: Your test code here!
      @all[5].status.must_equal :pending
      @all[5].add_product("name", 34.34).must_equal true
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
      @all.must_be_instance_of Array
      @all[1].must_be_instance_of Grocery::OnlineOrder
      @all.length.must_equal 100
      @all[1].customer.must_be_instance_of Integer
      @all[1].status.must_be_instance_of Symbol
    end
  end

  describe "OnlineOrder.find()" do
    it "Tests find method for OnlineOrder" do
      # TODO: Your test code here!
      Grocery::OnlineOrder.find(12).id.must_equal 12
      Grocery::OnlineOrder.find(12).status.must_equal :complete
    end
  end

  describe "OnlineOrder.find_by_customer" do
    it "Returns an array of online orders for a specific customer ID" do
      # TODO: Your test code here!
      Grocery::OnlineOrder.find_by_customer(12).length.must_equal 7
      Grocery::OnlineOrder.find_by_customer(12).must_be_instance_of Array
    end
  end
end
