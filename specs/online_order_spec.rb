require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require 'online_order.rb'
require_relative '../lib/customer.rb'

describe "OnlineOrder" do
  describe "#initialize" do
    it "Is a kind of Order" do

      id = 12
      products = { "banana" => 1.99, "cracker" => 3.00 }
      customer_id = 9
      status = :pending

      online_order = Grocery::OnlineOrder.new(id, products, customer_id, status)
      online_order.must_be_kind_of Grocery::Order

      online_order.id.must_equal id
      online_order.must_respond_to :products

    end

    it "Can access Customer object" do
      id = 12
      products = { "banana" => 1.99, "cracker" => 3.00 }
      customer_id = 9
      status = :pending

      online_order = Grocery::OnlineOrder.new(id, products, customer_id, status)
      online_order.must_respond_to :customer_id
      online_order.customer_id.must_be_kind_of Grocery::Customer
    end


    it "Can access the online order status" do
      id = 12
      products = { "banana" => 1.99, "cracker" => 3.00 }
      customer_id = 9
      status = :pending

      online_order = Grocery::OnlineOrder.new(id, products, customer_id, status)
      online_order.must_respond_to :status
      online_order.status.must_be_kind_of Symbol

   end
  end

  describe "#total" do
    it "Adds a shipping fee" do
      products = { "banana" => 1.99, "cracker" => 3.00 }
      online_order = Grocery::OnlineOrder.new(12, products, 10, :pending)
      sum = products.values.inject(0, :+)
      expected_total = sum + (sum * 0.075).round(2) + 10
      online_order.total.must_equal expected_total
    end

    it "Doesn't add a shipping fee if there are no products" do
      products = {}
      online_order = Grocery::OnlineOrder.new(12, products, 10, :pending)
      if products.length == 0
        online_order.total.must_equal 0
      end
    end
  end

  describe "#add_product" do
    it "Does not permit action for processing, shipped or completed statuses" do
      statuses = [:processing, :shipped, :completed]
      statuses.each do |status|
        products = { "banana" => 1.99, "cracker" => 3.00 }
        online_order = Grocery::OnlineOrder.new(12, products, 10, status)
        if online_order.status == status
          proc{online_order.add_product("diane", 24)}.must_raise ArgumentError
        end
      end
    end

    it "Permits action for pending and paid satuses" do
      statuses = [:pending, :paid]
      statuses.each do |status|
        products = { "banana" => 1.99, "cracker" => 3.00 }
        online_order = Grocery::OnlineOrder.new(12, products, 10, status)
        online_order.add_product("sandwich", 4.25)
        online_order.products.include?("sandwich").must_equal true
      end
    end
  end

  describe "OnlineOrder.all" do
    it "Returns an array of all online orders" do
      #   - The status is present

      online_order = Grocery::OnlineOrder.all
      online_order.must_be_kind_of Array
      online_order.each do |order|
        order.must_be_kind_of Grocery::Order
      end
      Grocery::OnlineOrder.online_line_count.must_equal online_order.length
      online_order.each do |order|
        order.customer_id.must_be_kind_of Grocery::Customer
      end
    end
  end

  describe "OnlineOrder.find" do
    it "Can find the first order from the CSV" do
      Grocery::OnlineOrder.all
      id = Grocery::OnlineOrder.find(1).id.to_i
      id.must_equal 1
    end

    it "Can find the last order from the CSV" do
      Grocery::OnlineOrder.all
      id = Grocery::OnlineOrder.find(20).id.to_i
      id.must_equal 20
    end

    it "Raises an error for an order that doesn't exist" do
       proc{Grocery::OnlineOrder.find(200)}.must_raise ArgumentError
    end
  end

  describe "OnlineOrder.find_by_customer" do
    it "Returns an array of online orders for a specific customer ID" do
      Grocery::OnlineOrder.all
      online_order = Grocery::OnlineOrder.find_by_customer(12)
      online_order.must_be_kind_of Array
      online_order.each do |order|
        order.must_be_kind_of Grocery::OnlineOrder
        order.customer_id.must_be_kind_of Grocery::Customer
        order.customer_id.id.to_i.must_equal 12
      end
    end
  end
end
