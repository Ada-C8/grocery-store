require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'

require_relative '../lib/online_order'

describe "OnlineOrder" do
  describe "#initialize" do
    it "Is a kind of Order" do
      online_order = Grocery::OnlineOrder.all[0]
      online_order.must_be_instance_of Grocery::OnlineOrder
      online_order.must_be_kind_of Grocery::Order
    end

    it "Can access Customer object" do
      online_order = Grocery::OnlineOrder.all[0]

      online_order.must_respond_to :customer
      online_order.customer.must_be_instance_of Grocery::Customer
    end

    it "Can access the online order status" do
      online_order = Grocery::OnlineOrder.all[-1]

      online_order.must_respond_to :status
      [:pending, :processing, :shipped, :complete, :paid].must_include online_order.status
    end
  end

  describe "#total" do
    it "Adds a shipping fee" do
      first_order = Grocery::OnlineOrder.all[0]
      first_order_products = Grocery::OnlineOrder.all[0].products
      sum = first_order_products.values.inject(0,:+)
      expected_total = (sum + (sum * 0.075)).round(2) + 10

      first_order.total.must_equal expected_total
    end

    it "Doesn't add a shipping fee if there are no products" do
      products = {}
      order = Grocery::OnlineOrder.new(1337, products, 1, :pending)

      order.total.must_equal 0
    end
  end

  describe "#add_product" do
    it "Does not permit action for processing, shipped or completed statuses" do
      complete_online_order = Grocery::OnlineOrder.all[0]
      processing_online_order = Grocery::OnlineOrder.all[2]
      shipped_online_order = Grocery::OnlineOrder.all[4]

      [complete_online_order, processing_online_order,shipped_online_order].each do |online_order|
        before_count = online_order.products.count

        online_order.add_product("silly string", 4)
        after_count = online_order.products.count

        after_count.must_equal before_count
      end

    end

    it "Permits action for pending and paid satuses" do
      paid_online_order =  Grocery::OnlineOrder.all[1]
      pending_online_order = Grocery::OnlineOrder.all[5]

      [paid_online_order, pending_online_order].each do |online_order|
        before_count = online_order.products.count

        online_order.add_product("silly string", 4)
        after_count = online_order.products.count

        after_count.must_be :>, before_count

        online_order.products.keys.must_include "silly string"
        online_order.products["silly string"].must_equal 4
      end

    end
  end

  describe "OnlineOrder.all" do
    it "Returns an array of all online orders" do

      Grocery::OnlineOrder.all.must_be_kind_of Array

      Grocery::OnlineOrder.all.each do |online_ord|
        online_ord.must_be_kind_of Grocery::OnlineOrder
      end

      Grocery::OnlineOrder.all.count.must_equal CSV.read("support/online_orders.csv", "r").count

      online_order = Grocery::OnlineOrder.all[0]

      online_order.customer.must_be_instance_of Grocery::Customer
      
      [:pending, :processing, :shipped, :complete, :paid].must_include online_order.status
    end


  end

  describe "OnlineOrder.find_by_customer" do
    it "Returns an array of online orders for a specific customer ID" do
      customer35_orders = Grocery::OnlineOrder.find_by_customer(35)

      customer35_orders.must_be_instance_of Array

      customer35_orders.count.must_equal 4

      customer35_orders.each {|online_order| online_order.must_be_instance_of Grocery::OnlineOrder }

      customer35_orders.each {|online_order| [4,47,56,58].must_include online_order.id }

      proc { Grocery::OnlineOrder.find_by_customer(1042) }.must_raise ArgumentError

    end

  end

  describe "OnlineOrder.find(id)" do
    it "Can be called " do
      all_online_orders = Grocery::OnlineOrder.all

      all_online_orders.must_respond_to :find
    end

    it "Can find the right order" do
      online_order_42 = Grocery::OnlineOrder.find(42)

      online_order_42.must_be_instance_of Grocery::OnlineOrder

      online_order_42.id.must_equal 42
      ["Tea Oil", "Tapioca", "Kidney Beans"].each do |product|
        online_order_42.products.keys.must_include product
      end
      online_order_42.status.must_equal :shipped

    end

    it "Raises an error for an online order that does not exist" do
      proc { Grocery::OnlineOrder.find(800) }.must_raise ArgumentError
    end

  end

end
