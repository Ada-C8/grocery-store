require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/online_order'

describe "OnlineOrder" do
  describe "#initialize" do
    before do
      Grocery::Customer.read(File.expand_path('../..', __FILE__) + "/support/customers.csv")
      @online_order = Grocery::OnlineOrder.new(["1","Lobster:17.18;Annatto seed:58.38;Camomile:83.21","25","complete"])
    end
    it "Is a kind of Order" do
      @online_order.must_be_kind_of Grocery::Order
    end

    it "Can access Customer object" do
      @online_order.customer.class.must_equal Grocery::Customer
    end

    it "Can access the online order status" do
      Grocery::OnlineOrder.find(1).status.must_equal :complete
    end
  end

  describe "#total" do
    before do
      Grocery::Customer.read(File.expand_path('../..', __FILE__) + "/support/customers.csv")
      @online_order = Grocery::OnlineOrder.new(["1","Lobster:17.18;Annatto seed:58.38;Camomile:83.21","25","complete"])
    end
    it "Adds a shipping fee" do
      @online_order.total.must_equal ((17.18 + 58.38 + 83.21) * 1.075).round(2) + 10
    end

    it "Doesn't add a shipping fee if there are no products" do
      new_order = Grocery::OnlineOrder.new(["1","","25","complete"])
      new_order.total.must_equal 0
    end
  end

  describe "#add_product" do
    before do
      Grocery::Customer.read(File.expand_path('../..', __FILE__) + "/support/customers.csv")
    end
    it "Does not permit action for processing, shipped or completed statuses" do
      online_order = Grocery::OnlineOrder.new(["1","Lobster:17.18;Annatto seed:58.38;Camomile:83.21","25","complete"])
      proc {online_order.add_product("sandwich",100)}.must_raise ArgumentError
    end

    it "Permits action for pending and paid satuses" do
      ["paid","pending"].each do |status|
        online_order = Grocery::OnlineOrder.new(["1","Lobster:17.18;Annatto seed:58.38;Camomile:83.21","25",status])
        online_order.add_product("sandwich",100).must_equal true
      end
    end
  end

  describe "OnlineOrder.all" do
    it "Returns an array of all online orders" do
      Grocery::Customer.read(File.expand_path('../..', __FILE__) + "/support/customers.csv")
      Grocery::OnlineOrder.read(File.expand_path('../..', __FILE__) + "/support/online_orders.csv")
      # TODO: Your test code here!
      # Useful checks might include:
      #   - The customer is present
      #   - The status is present
      # Feel free to split this into multiple tests if needed
      Grocery::OnlineOrder.all.class.must_equal Array
      Grocery::OnlineOrder.all.length.must_equal 100
      Grocery::OnlineOrder.all.each do |order|
        order.class.must_equal Grocery::OnlineOrder
        order.customer.class.must_equal Grocery::Customer
        order.status.must_be_instance_of Symbol
      end
    end
  end

  xdescribe "OnlineOrder.find_by_customer" do
    it "Returns an array of online orders for a specific customer ID" do
      Grocery::Customer.read(File.expand_path('../..', __FILE__) + "/support/customers.csv")
      Grocery::OnlineOrder.read(File.expand_path('../..', __FILE__) + "/support/online_orders.csv")
      Grocery::OnlineOrder.find_by_customer(25).must_be_instance_of Array
      Grocery::OnlineOrder.find_by_customer(25).each do |order|
        order.must_be_instance_of Grocery::OnlineOrder
      end
    end
  end
end
