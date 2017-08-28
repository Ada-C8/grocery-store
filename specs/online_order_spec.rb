require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'

# TO-DO: uncomment the next line once you start wave 3
require_relative '../lib/online_order'
# You may also need to require other classes here

# Because an OnlineOrder is a kind of Order, and we've
# already tested a bunch of functionality on Order,
# we effectively get all that testing for free! Here we'll
# only test things that are different.

describe "OnlineOrder" do
  before do
    online_id = 1
    products = {"Lobster" => 17.18, "Annatto seed" => 58.38, "Camomile" => 83.21}
    customer = 25
    status = :complete

    @online_order = Grocery::OnlineOrder.new(online_id, products, customer, status)
  end

  describe "#initialize" do
    it "Is a kind of Order" do
      # Check that an OnlineOrder is in fact a kind of Order
      @online_order.must_be_kind_of Grocery::Order
    end

    it "Can access Customer object" do #customer object = instance of customer
      @online_order.customer.must_be_instance_of Grocery::Customer
    end

    it "Can access the online order status" do
      @online_order.status.must_be_kind_of Symbol
    end
  end

  describe "#total" do
    it "Adds a shipping fee" do
      test_total = 17.18 + 58.38 + 83.21
      @online_order.total.must_equal(test_total + (test_total * 0.075).round(2) + 10) #beware of rounding errors!
    end

    it "Doesn't add a shipping fee if there are no products" do
      online_id = 101
      products = {}
      customer = 20
      status = :pending

      no_products_order = Grocery::OnlineOrder.new(online_id, products, customer, status)
      no_products_order.total.must_equal(0)
    end
  end

  describe "#add_product" do
    it "Does not permit action for processing, shipped or completed statuses" do
      online_id = 60
      products = {"Hummus" => 90.71}
      customer = 30
      status = :complete #TEST status using :processing, :shipped, or :complete

      no_add_order = Grocery::OnlineOrder.new(online_id, products, customer, status)
      proc { no_add_order.add_product("Oregano", 15.35) }.must_raise ArgumentError
      no_add_order.products.keys.include?("Oregano").must_equal false

    end

    it "Permits action for pending and paid satuses" do
      online_id = 55
      products = {"Fennel" => 57.35}
      customer = 6
      status = :pending

      pending_order = Grocery::OnlineOrder.new(online_id, products, customer, status)

      pending_order.add_product("Oregano", 15.35)
      pending_order.products.include?("Oregano").must_equal true

      online_id = 82
      products = {"Asafoetida" => 55.33}
      customer = 31
      status = :paid

      paid_order = Grocery::OnlineOrder.new(online_id, products, customer, status)

      paid_order.add_product("Oregano", 15.35)
      paid_order.products.include?("Oregano").must_equal true

    end
  end

  describe "OnlineOrder.all" do
    # Useful checks might include:
    #   - OnlineOrder.all returns an array
    #   - Everything in the array is an Order
    #   - The number of orders is correct
    #   - The customer is present
    #   - The status is present
    # Feel free to split this into multiple tests if needed
    before do
      @online_orders = Grocery::OnlineOrder.all
    end

    it "Returns an array of all online orders" do
      @online_orders.class.must_equal Array
    end

    it "Everything in the returned array is an OnlineOrder" do

      all_instances_are_online = true
      @online_orders.each do |online_order|
        if online_order.class != Grocery::OnlineOrder
          all_instances_are_online = false
        end
      end
      all_instances_are_online.must_equal true
    end

    it "Returns the correct number of online orders" do
      @online_orders.length.must_equal 100
    end

    it "Confirms customer is present" do
      online_id = 55
      products = {"Fennel" => 57.35}
      customer = 0
      status = :pending

      # customer_order = Grocery::OnlineOrder.new(online_id, products, customer, status) Lesson: Can't substitute customer_order inside proc {} because it will raise an error before catching it
      proc { Grocery::OnlineOrder.new(online_id, products, customer, status) }.must_raise(ArgumentError)

    end

    it "Confirms status is present (no status = :pending)" do
      online_id = 55
      products = {"Fennel" => 57.35}
      customer = 3
      #no status will be entered

      status_order = Grocery::OnlineOrder.new(online_id, products, customer) #status is not entered as an argument, because entering a status argument (even if it is nil or "") would enter a default value of :pending
      status_order.status.must_equal(:pending)
    end

    it "Confirms status must have a valid value of :pending, :paid, :processing, :shipped or :complete" do
      online_id = 55
      products = {"Fennel" => 57.35}
      customer = 3
      status = "x" #TEST using nil or "" or any input that's not a valid status

      proc { Grocery::OnlineOrder.new(online_id, products, customer, status) }.must_raise(ArgumentError)
    end
  end

  describe "OnlineOrder.find_by_customer" do
    it "Returns an array of online orders for a specific customer ID" do

    end
  end
end
