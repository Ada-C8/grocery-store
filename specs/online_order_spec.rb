require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'

require_relative '../lib/online_order'
require_relative '../lib/order'
require_relative '../lib/customer' 

describe "OnlineOrder" do
  describe "#initialize" do
    it "Is a kind of Order" do
      id = 1
      products = "Lobster:17.18; Annatto seed:58.38; Camomile:83.21"
      customer = 25
      status = "complete"
      on_order = Grocery::OnlineOrder.new(id, products, customer, status)
      on_order.must_respond_to :id
      on_order.must_respond_to :products
      on_order.must_respond_to :customer
      on_order.must_respond_to :status
      on_order.must_be_kind_of Grocery::Order
    end
    it "Can access Customer object" do
      Grocery::OnlineOrder.all[99].customer.must_be_instance_of Grocery::Customer    
    end
    it "Can access the online order status" do
      Grocery::OnlineOrder.all[0].status.must_equal :complete
      Grocery::OnlineOrder.all[99].status.must_equal :pending
    end    
  end

  describe "total" do
    it "Adds a shipping fee" do
      first_order = Grocery::OnlineOrder.new(1, { "Lobster"=>17.18, "Annatto seed"=>58.38,"Camomile"=>83.21}, "customer", "test")
      first_order.total.must_equal 180.68
    end
    it "Doesn't add a shipping fee if there are no products" do
      id = 1337
      customer = "customer"
      status = "processing"
      products = {}
      online_order = Grocery::OnlineOrder.new(id, products, customer, status)
      online_order.total.must_equal 0
    end
  end

  describe "add_product" do
    it "Does not permit action for processing, shipped or completed statuses" do
      id = 1337
      customer = "customer"
      status = "processing"
      products = { "banana" => 1.99, "cracker" => 3.00 }
      online_order = Grocery::OnlineOrder.new(id, products, customer, status)
      proc {online_order.add_product("banana", 1.99)}.must_raise ArgumentError
    end
    it "Permits action for pending and paid satuses" do
      customer = "customer"
      id = 1337
      products = { "banana" => 1.99, "cracker" => 3.00 }
      online_order = Grocery::OnlineOrder.new(id, products, customer)
      online_order.add_product("strawberry", 1.99).must_equal true
    end
  end

  describe "OnlineOrder.all" do
    it "Returns an array of all online orders" do
      Grocery::OnlineOrder.all.must_be_kind_of Array
    end
    it "Online Orders are orders" do
      Grocery::OnlineOrder.must_be_kind_of Class
    end
    it "Online Orders are all accounted for" do
      Grocery::OnlineOrder.all.length.must_equal 100
    end
    it "Customer ID is correct" do
      Grocery::OnlineOrder.all[0].customer.id.must_equal 25
      Grocery::OnlineOrder.all[99].customer.id.must_equal 20
    end
    it "Can access the online order status" do
      Grocery::OnlineOrder.all[0].status.must_equal :complete
      Grocery::OnlineOrder.all[99].status.must_equal :pending
    end
  end

  describe "OnlineOrder.find_by_customer" do
    it "Returns an array of online orders for a specific customer ID" do
      Grocery::OnlineOrder.find_by_customer(3).length.must_equal 1
    end
  end
end





