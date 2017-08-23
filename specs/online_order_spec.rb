require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/online_order'

describe "OnlineOrder" do
  describe "#initialize" do
    before do
      Grocery::Customer.read(File.expand_path('../..', __FILE__) + "/support/customers.csv")
      @online_order = OnlineOrder.new(["1","Lobster:17.18;Annatto seed:58.38;Camomile:83.21","25","complete"])
    end
    it "Is a kind of Order" do
      @online_order.must_be_kind_of Grocery::Order
    end

    it "Can access Customer object" do
      @online_order.customer.class.must_equal Grocery::Customer
    end

    it "Can access the online order status" do
      OnlineOrder.find(1).status.must_equal "complete"
    end
  end

  describe "#total" do
    before do
      Grocery::Customer.read(File.expand_path('../..', __FILE__) + "/support/customers.csv")
      @online_order = OnlineOrder.new(["1","Lobster:17.18;Annatto seed:58.38;Camomile:83.21","25","complete"])
    end
    xit "Adds a shipping fee" do

    end

    xit "Doesn't add a shipping fee if there are no products" do
      # TODO: Your test code here!
    end
  end

  xdescribe "#add_product" do
    it "Does not permit action for processing, shipped or completed statuses" do
      # TODO: Your test code here!
    end

    it "Permits action for pending and paid satuses" do
      # TODO: Your test code here!
    end
  end

  xdescribe "OnlineOrder.all" do
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

  xdescribe "OnlineOrder.find_by_customer" do
    it "Returns an array of online orders for a specific customer ID" do
      # TODO: Your test code here!
    end
  end
end
