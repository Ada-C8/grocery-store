require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'

require_relative '../lib/online_order'
require_relative '../lib/order'

require 'pry'
# You may also need to require other classes here

# Because an OnlineOrder is a kind of Order, and we've
# already tested a bunch of functionality on Order,
# we effectively get all that testing for free! Here we'll
# only test things that are different.

describe "OnlineOrder" do
  before do
    @online_order = Grocery::OnlineOrder.new(1000, {apples: 2.00, bananas: 1.00}, 30)
  end

  describe "#initialize" do

    it "Is a kind of Order" do
      # Instatiate your OnlineOrder here
      @online_order.must_be_kind_of Grocery::Order
    end

    it "Can access Customer object" do

      @online_order.must_respond_to :customer_id
    end

    it "Can access the online order status" do
      @online_order.must_respond_to :status
    end
  end

  describe "#total" do
    it "Adds a shipping fee" do
      sum = 0
      products = @online_order.products

      products.each do |key, value|
          sum += value
      end
      sum_incl_tax = (sum + (sum * 0.075)).round(2)
      @online_order.total.must_equal (sum_incl_tax + 10).round(2)
    end

    it "Doesn't add a shipping fee if there are no products" do
      if @online_order.products == nil || @online_order.products == 0
        @online_order.total.must_equal 0
      end
    end
  end

  describe "#add_product" do
    before do
      @new_online_orders = []
      @new_online_orders << Grocery::OnlineOrder.new(1000, {apples: 2.00, bananas: 1.00}, 30, :completed)
      @new_online_orders << Grocery::OnlineOrder.new(1000, {apples: 2.00, bananas: 1.00}, 30, :shipped)
      @new_online_orders << Grocery::OnlineOrder.new(1000, {apples: 2.00, bananas: 1.00}, 30, :processing)
    end

    it "Does not permit action for processing, shipped or completed statuses" do
      @new_online_orders.each do |order|
        #unless order.status == :pending
          proc{order.add_product(dogtreats: 5.00)}.must_raise ArgumentError
        #end
      end
    end

    it "Permits action for pending and paid satuses" do
      # TODO: Your test code here!
    end
  end

  xdescribe "OnlineOrder.all" do
    it "Returns an array of all online orders" do
      # Useful checks might include:
      #   - OnlineOrder.all returns an array
      Grocery::OnlineOrder.all.must_be_kind_of Array
      #   - Everything in the array is an Order
      Grocery::OnlineOrder.all[1].must_be_instance_of Grocery::Order
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
