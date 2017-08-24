require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'

require_relative '../lib/online_order'
# You may also need to require other classes here

describe "OnlineOrder" do
  describe "#initialize" do
    before do
      products = [{"peas" => 2}, {"beer" => 8}]
      customer = Grocery::Customer.new(34, "email", "address")
      status = :pending
      @online_order = Grocery::OnlineOrder.new(1, products, customer, status)
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
    it "Does not permit action for processing, shipped or completed statuses" do
      # TODO: Your test code here!
    end

    it "Permits action for pending and paid satuses" do
      # TODO: Your test code here!
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
    end
  end

  describe "OnlineOrder.find_by_customer" do
    it "Returns an array of online orders for a specific customer ID" do
      # TODO: Your test code here!
    end
  end
end
