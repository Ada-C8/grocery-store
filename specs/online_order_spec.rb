require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require 'csv'

# TODO: uncomment the next line once you start wave 3
require_relative '../lib/online-order'
require_relative '../lib/order'
require_relative '../lib/customer'
# You may also need to require other classes here

# Because an OnlineOrder is a kind of Order, and we've
# already tested a bunch of functionality on Order,
# we effectively get all that testing for free! Here we'll
# only test things that are different.

describe "OnlineOrder" do
  before do
    @id_order = 3
    @products = { "banana" => 1.99, "cracker" => 3.00 }
    id = 101
    email = "aekitsch@gmail.com"
    address = {
      address_line: "3932 S 284th Pl",
      city: "Auburn",
      state: "WA",
      zip_code: "98001"
    }
    @customer = Grocery::Customer.new(id,email,address)
    @online_order = Grocery::OnlineOrder.new(@id_order, @products, @customer, status: :complete)
    @online_order_status = Grocery::OnlineOrder.new(@id_order, @products, @customer)
  end
  describe "#initialize" do
    it "Is a kind of Order" do
      # Check that an OnlineOrder is in fact a kind of Order
      # Instatiate your OnlineOrder here
      @online_order.must_be_kind_of Grocery::Order
    end

    it "Can access Customer object" do
      @online_order.customer.must_be_instance_of Grocery::Customer
      # @oline_order.customer.id.must_equal 101
      proc{Grocery::OnlineOrder.new(@id_order,@products,"averi", status: :complete)}.must_raise ArgumentError
    end

    it "Can access the online order status" do
      @online_order.status.must_equal :complete
      online_order2 = Grocery::OnlineOrder.new(@id_order,@products,@customer)
      online_order2.status.must_equal :pending
      proc{Grocery::OnlineOrder.new(@id_order,@products,@customer, status: :trying)}.must_raise ArgumentError

    end
  end

  describe "#total" do
    it "Adds a shipping fee" do
      price = (4.99* 1.075).round(2) +10
      @online_order.total.must_equal price
    end

    it "Doesn't add a shipping fee if there are no products" do
      order = Grocery::OnlineOrder.new(@id_order, {}, @customer, status: :complete)
      order.total.must_equal 0
    end
  end

  describe "#add_product" do
    it "Does not permit action for processing, shipped or complete statuses" do
      [:processing, :shipped, :complete].each do |status|
        online_order = Grocery::OnlineOrder.new(@id_order, @products, @customer, status: status)
        proc{online_order.add_product("chicken",7.02)}.must_raise ArgumentError
      end
    end

    it "Permits action for pending and paid satuses" do
      @online_order_status.must_respond_to :add_product
      @online_order_status.add_product("chicken",7.02)
      @online_order_status.products.count.must_equal 3

      online_order2 = Grocery::OnlineOrder.new(@id_order, @products, @customer, status: :paid)
      online_order2.must_respond_to :add_product
      online_order2.add_product("chicken",7.02)
      online_order2.products.count.must_equal 3
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
      customer_csv = CSV.read("/Users/averikitsch/ada/03-week/grocery-store/support/customers.csv")
      order_csv = CSV.read("/Users/averikitsch/ada/03-week/grocery-store/support/online_orders.csv")
      online_orders = Grocery::OnlineOrder.all(customer_csv,order_csv)
      online_orders.must_be_instance_of Array

      online_orders.each do |order|
        order.must_be_instance_of Grocery::OnlineOrder
      end

      online_orders.length.must_equal order_csv.length

      online_orders[0].must_respond_to :customer
      online_orders[0].must_respond_to :status

      online_orders[-1].status.must_equal :pending

    end
  end

  describe "OnlineOrder.find" do
    it "returns the online order with correct id" do

    customer_csv = CSV.read("/Users/averikitsch/ada/03-week/grocery-store/support/customers.csv")
    order_csv = CSV.read("/Users/averikitsch/ada/03-week/grocery-store/support/online_orders.csv")
    Grocery::OnlineOrder.find(customer_csv, order_csv, 1).must_be_instance_of Grocery::OnlineOrder

    online_order1 = Grocery::OnlineOrder.find(customer_csv, order_csv, 1)
    order_first = {"Lobster" => 17.18,"Annatto seed"=>58.38,"Camomile"=>83.21}
    online_order1.products.must_equal order_first
    end
  end

  describe "OnlineOrder.find_by_customer" do
    it "Returns an array of online orders for a specific customer ID" do
      customer_csv = CSV.read("/Users/averikitsch/ada/03-week/grocery-store/support/customers.csv")
      order_csv = CSV.read("/Users/averikitsch/ada/03-week/grocery-store/support/online_orders.csv")

      Grocery::OnlineOrder.must_respond_to :find_by_customer

      orders = Grocery::OnlineOrder.find_by_customer(customer_csv, order_csv, 10)
      orders.must_be_instance_of Array
      orders[0].must_be_instance_of Grocery::OnlineOrder
      orders[0].id.must_equal 2
    end
  end
end
