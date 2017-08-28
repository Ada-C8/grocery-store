
require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require 'minitest/pride'

require_relative '../lib/online_order'
require_relative '../lib/order'

describe "OnlineOrder" do
  before do
    @online_order = Grocery::OnlineOrder.new(1, {"Lobster" => 17.18, "Annatto seed" => 58.38, "Camomile" => 83.21}, 25, :complete)
  end
  describe "#initialize" do
    it "Is a kind of Order" do
      # Check that an OnlineOrder is in fact a kind of Order
      @online_order.must_be_kind_of Grocery::Order
    end

    it "Can access Customer object" do
      @online_order.customer.must_equal Grocery::Customer.find(25)
    end

    it "Can access the online order status" do
      @online_order.must_respond_to :status
    end

    it "Pending is default status" do
      statusless = Grocery::OnlineOrder.new(1, {"Lobster" => 17.18, "Annatto seed" => 58.38, "Camomile" => 83.21}, 25)

      statusless.status.must_equal :pending
    end
  end

  describe "#total" do
    it "Adds a shipping fee" do
        order = Grocery::Order.new(1, {"Lobster" => 17.18, "Annatto seed" => 58.38, "Camomile" => 83.21})
      @online_order.total.must_equal (order.total + 10)
      # (180.68)
    end

    it "Doesn't add a shipping fee if there are no products" do
      product_free = Grocery::OnlineOrder.new(35, {}, 25, :complete)
      product_free.total.must_equal 0
    end
  end

  describe "#add_product" do
    it "Does not permit action for processing, shipped or complete statuses" do
      proc {@online_order.add_product("Kale", 2.99)}.must_raise ArgumentError
      @online_order.products.length.must_equal 3
    end

    it "Permits action for pending and paid satuses" do
      pending = Grocery::OnlineOrder.new(1, {"Lobster" => 17.18, "Annatto seed" => 58.38, "Camomile" => 83.21}, 25, :paid)
      pending.add_product("Kale", 2.99).must_equal true
      pending.products.length.must_equal 4
    end
  end

  describe "OnlineOrder.find" do
    it "checks the find method" do
      Grocery::OnlineOrder.find(1).products.must_equal @online_order.products
    end
  end

  describe "OnlineOrder.all" do
    before do
      @online_orders = Grocery::OnlineOrder.all
    end

    it "Returns an array" do
      @online_orders.must_be_kind_of Array
    end

    it "Array is filled with Orders" do
      10.times do
        @online_orders[rand(100)].must_be_kind_of Grocery::Order
      end
    end

    it "Has right number of items" do
      @online_orders.length.must_equal 100
    end

    it "The customer is present" do
      customer = @online_orders[0].customer
      customer.must_equal Grocery::Customer.find(customer.id)
    end

    it "the status is present" do
      @online_orders[0].status.must_equal :complete
    end
  end

  describe "OnlineOrder.find_by_customer" do
    before do
    @customers_orders = Grocery::OnlineOrder.find_by_customer(15)
    end
    it "Returns an array." do
      @customers_orders.must_be_kind_of Array
    end
    it "Returns the right number of orders" do
      @customers_orders.length.must_equal 3
    end
  end
end
