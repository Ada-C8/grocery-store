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

###TODO
    it "Doesn't add a shipping fee if there are no products" do
      new_online_order = Grocery::OnlineOrder.new(1000, {}, 30)
      new_online_order.total.must_equal 0
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
          proc{order.add_product("dogtreats", 5.00)}.must_raise ArgumentError
        end
    end

    it "Permits action for pending and paid satuses" do
      @new_online_orders[0].status = :paid
      @new_online_orders[1].status = :pending
      @new_online_orders[2].status = :paid

      @new_online_orders.each do |order|
        length_before = order.products.length
        order.add_product("steak", 10.00)
        length_after = order.products.length
        length_after.must_equal (length_before + 1)
      end
    end
  end

  describe "OnlineOrder.all" do
    it "Returns an array of all online orders" do
      # Useful checks might include:
      #   - OnlineOrder.all returns an array
      all_online_orders = Grocery::OnlineOrder.all
      all_online_orders.must_be_kind_of Array
      #   - Everything in the array is an Order
      Grocery::OnlineOrder.all[1].must_be_instance_of Grocery::OnlineOrder
      all_online_orders.each do |order|
        order.must_be_instance_of Grocery::OnlineOrder
        order.must_be_kind_of Grocery::Order
        order.must_respond_to :customer_id
        order.must_respond_to :status
      end
      #The number of orders is correct
      all_online_orders.count.must_equal 100
    end
  end

describe "OnlineOrder.find_by_customer" do
    it "Returns an array of online orders for a specific customer ID" do
      Grocery::OnlineOrder.find_by_customer(1).must_be_kind_of Array
      #all_online_orders = Grocery::OnlineOrder.all

      customer_orders = Grocery::OnlineOrder.find_by_customer(1)
        customer_orders.each do |order|
          order.customer_id.must_equal 1
      end

    end
  end

#TODO: Not finished
describe "OnlineOrder.find" do
  before do
    @all_online_orders = Grocery::OnlineOrder.all
  end
  it "Can find the first order from the CSV" do
    Grocery::OnlineOrder.find(1).id.must_equal @all_online_orders[0].id
  end
  it "Can find the last order from the CSV" do
    Grocery::OnlineOrder.find(100).id.must_equal 100
  end

  it "Raises an ArgumentError if order does not exist" do
    proc{Grocery::OnlineOrder.find(1000)}.must_raise ArgumentError
  end

end
end
