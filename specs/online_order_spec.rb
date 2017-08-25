require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/customer.rb'
require_relative '../lib/order.rb'
require_relative '../lib/online-order.rb'
require 'csv'

# TODO: uncomment the next line once you start wave 3
# require_relative '../lib/online_order'
# You may also need to require other classes here

# Because an OnlineOrder is a kind of Order, and we've
# already tested a bunch of functionality on Order,
# we effectively get all that testing for free! Here we'll
# only test things that are different.

describe "OnlineOrder" do
  before do
    @myord = Grocery::OnlineOrder.new(CSV.read("../support/online_orders.csv").first[0],CSV.read("../support/online_orders.csv").first[1..-1])


    @myord2 = Grocery::OnlineOrder.new(CSV.read("../support/online_orders.csv").last[0],CSV.read("../support/online_orders.csv").last[1..-1])


    @allord = Grocery::OnlineOrder.all

  end

  describe "#initialize" do

    it "Is a kind of Order" do
      # Check that an OnlineOrder is in fact a kind of Order

      @myord.must_be_kind_of Grocery::Order

      @myord2.must_be_kind_of Grocery::Order

       @allord.each do |online_order|
        online_order.must_be_kind_of Grocery::Order
      end

      # Instatiate your OnlineOrder here
      # online_order =
      # online_order.must_be_kind_of Grocery::Order
    end

    it "Can access Customer object" do

      @myord2.customer.must_be_instance_of Grocery::Customer

      @myord2.customer.must_be_instance_of Grocery::Customer

       @allord.each do |online_order|
        online_order.customer.must_be_instance_of Grocery::Customer
      end

    end

    it "Can access the online order status" do

      [:processing, :paid, :complete, :shipped, :pending].must_include @myord.status

      @myord.must_respond_to :status

      [:processing, :paid, :complete, :shipped, :pending].must_include @myord2.status

      @myord2.must_respond_to :status

       @allord.each do |online_order|
        [:processing, :paid, :complete, :shipped, :pending].must_include online_order.status
      end
    end
  end

  describe "#total" do
    it "Adds a shipping fee" do

    end

    it "Doesn't add a shipping fee if there are no products" do
      # TODO: Your test code here!
      sum = 0
      @myord.products.each do |name, price|
        sum += price.to_f
      end
      sum_tax = sum + sum * (7.5/100)
      sum_tax_ship = sum_tax + 10
      sum_tax_ship = sum_tax_ship.round(2)
      @myord.total.must_be :==,sum_tax_ship
    end
  end

  describe "#add_product" do
    it "Does not permit action for processing, shipped or completed statuses" do
      # TODO: Your test code here!
      @allord.each do |online_order|
        if online_order.status == :processing || online_order.status == :shipped || online_order.status == :completed
          proc {online_order.add_product(CSV.read("../support/online_orders.csv").first[0],CSV.read("../support/online_orders.csv").first[1..-1])}.must_raise ArgumentError
        end
      end

    end

    it "Permits action for pending and paid satuses" do
      # TODO: Your test code here!
      @allord.each do |online_order|
        if online_order.status == :paid
          proc {return online_order.add_product(CSV.read("../support/online_orders.csv").first[0],CSV.read("../support/online_orders.csv").first[1..-1])}.must_output true
        end
      end
    end
  end

  describe "OnlineOrder.all" do
    it "Returns an array of all online orders" do
      # TODO: Your test code here!
      # Useful checks might include:
      #   - OnlineOrder.all returns an array
      @allord.must_be_kind_of Array
      #   - Everything in the array is an Order
      @allord.each do |online_order|
        online_order.must_be_kind_of Grocery::Order
        online_order.must_be_instance_of Grocery::OnlineOrder
      end
      #   - The number of orders is correct
      count = 0
      CSV.read("../support/online_orders.csv").each do |row|
        count += 1
      end
      @allord.count.must_be :==,count
      #   - The customer is present
      @allord.each do |online_orders|
        online_orders.must_respond_to :customer
      end
      #   - The status is present
      @allord.each do |online_orders|
        online_orders.must_respond_to :status
      end
      # Feel free to split this into multiple tests if needed
    end
  end

  describe "OnlineOrder.find_by_customer" do
    it "Returns an array of online orders for a specific customer ID" do
      # TODO: Your test code here!
      customers_ids = []
      @allord.each do |online_orders|
        customers_ids << online_orders.customer.id
      end
      customers_ids.each do |id|
        Grocery::OnlineOrder.find_by_customer(id).must_be_kind_of Array
      end
      Grocery::OnlineOrder.find_by_customer("1").must_be_kind_of Array
      @allord.each do |online_orders|
        Grocery::OnlineOrder.find_by_customer(online_orders.customer.id).must_be_kind_of Array
      end
    end
  end
end
