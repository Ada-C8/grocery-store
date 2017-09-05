require_relative 'spec_helper'

describe "OnlineOrder" do
  describe "#initialize" do
    it "Is a kind of Order" do
      # Check that an OnlineOrder is in fact a kind of Order
      email = "leonard.rogahn@hagenes.org"
      address = "71596 Eden Route,Connellymouth,LA,98872-9105"
      customer = Grocery::Customer.new(1, email, address)
      status = :paid
      products = { "banana" => 1.99, "cracker" => 3.00 }
      online_order = OnlineOrder.new(products, 20, customer, status)
      online_order.must_be_kind_of Grocery::Order
    end

    it "Can access Customer object" do
      email = "leonard.rogahn@hagenes.org"
      address = "71596 Eden Route,Connellymouth,LA,98872-9105"
      customer = Grocery::Customer.new(1, email, address)
      customer.must_be_instance_of Grocery::Customer
    end

    it "Can access the online order status" do
      email = "leonard.rogahn@hagenes.org"
      address = "71596 Eden Route,Connellymouth,LA,98872-9105"
      customer = Grocery::Customer.new(1, email, address)
      status = :paid
      products = { "banana" => 1.99, "cracker" => 3.00 }
      online_order = OnlineOrder.new(products, 20, customer, status)
      online_order.status.must_equal :paid
    end
  end

  describe "#total" do
    it "Adds a shipping fee" do
      email = "leonard.rogahn@hagenes.org"
      address = "71596 Eden Route,Connellymouth,LA,98872-9105"
      customer = Grocery::Customer.new(1, email, address)
      status = :paid
      products = { "banana" => 1.99, "cracker" => 3.00 }
      online_order = OnlineOrder.new(20, products, customer, status)
      online_order.total.must_equal 15.36
    end

    it "Doesn't add a shipping fee if there are no products" do
      email = "leonard.rogahn@hagenes.org"
      address = "71596 Eden Route,Connellymouth,LA,98872-9105"
      customer = Grocery::Customer.new(1, email, address)
      status = :paid
      products = {}
      online_order = OnlineOrder.new(20, products, customer, status)
      online_order.total.must_equal 0
    end
  end

  describe "#add_product" do
    it "Does not permit action for shipped statuses" do
      email = "leonard.rogahn@hagenes.org"
      address = "71596 Eden Route,Connellymouth,LA,98872-9105"
      customer = Grocery::Customer.new(1, email, address)
      status = :shipped
      products = { "banana" => 1.99, "cracker" => 3.00 }
      online_order = OnlineOrder.new(20, products, customer, status)

      proc {online_order.add_product("banana", 1.99)}.must_raise ArgumentError
    end

    it "Does not permit action for processing statuses" do
      email = "leonard.rogahn@hagenes.org"
      address = "71596 Eden Route,Connellymouth,LA,98872-9105"
      customer = Grocery::Customer.new(1, email, address)
      status = :processing
      products = { "banana" => 1.99, "cracker" => 3.00 }
      online_order = OnlineOrder.new(20, products, customer, status)

      proc {online_order.add_product("banana", 1.99)}.must_raise ArgumentError
    end

    it "Does not permit action for completed statuses" do
      email = "leonard.rogahn@hagenes.org"
      address = "71596 Eden Route,Connellymouth,LA,98872-9105"
      customer = Grocery::Customer.new(1, email, address)
      status = :complete
      products = { "banana" => 1.99, "cracker" => 3.00 }
      online_order = OnlineOrder.new(20, products, customer, status)

      proc {online_order.add_product("banana", 1.99)}.must_raise ArgumentError
    end

    it "Permits action for pending and paid statuses, if item already present" do
      email = "leonard.rogahn@hagenes.org"
      address = "71596 Eden Route,Connellymouth,LA,98872-9105"
      customer = Grocery::Customer.new(1, email, address)
      status = :paid
      products = { "banana" => 1.99, "cracker" => 3.00 }
      online_order = OnlineOrder.new(20, products, customer, status)
      online_order.add_product("banana", 1.99).must_equal false
    end

    it "Permits action for pending and paid statuses, if item is new" do
      email = "leonard.rogahn@hagenes.org"
      address = "71596 Eden Route,Connellymouth,LA,98872-9105"
      customer = Grocery::Customer.new(1, email, address)
      status = :paid
      products = { "banana" => 1.99, "cracker" => 3.00 }
      online_order = OnlineOrder.new(20, products, customer, status)
      online_order.add_product("orange", 3.99).must_equal true
    end

    it "Is added to the collection of products" do
      email = "leonard.rogahn@hagenes.org"
      address = "71596 Eden Route,Connellymouth,LA,98872-9105"
      customer = Grocery::Customer.new(1, email, address)
      status = :paid
      products = { "banana" => 1.99, "cracker" => 3.00 }
      online_order = OnlineOrder.new(20, products, customer, status)
      online_order.add_product("orange", 3.99)
      online_order.products.include?("orange").must_equal true
    end
  end # DESCRIBE

  describe "OnlineOrder.all" do
    it "Returns an array of all online orders" do
      OnlineOrder.all.must_be_kind_of Array
    end

    it "Everything in the array is an Order" do
      OnlineOrder.all.each do |order|
        order.must_be_instance_of OnlineOrder
      end
    end

    it "The number of total online orders is correct" do
      OnlineOrder.all.count.must_equal 100
    end

    it "The customer is present" do
      OnlineOrder.all.each do |order|
        order.customer.must_be_instance_of Grocery::Customer
      end
    end

    it "The status is present" do
      OnlineOrder.all.each do |order|
        order.status.must_be_kind_of Symbol
      end
    end
  end # DESCRIBE

  describe "OnlineOrder.find" do
    it "Online order is an Online Order" do
      OnlineOrder.find(1).must_be_instance_of OnlineOrder
    end

    it "Online order ID must match requested order number" do
      OnlineOrder.find(1).id.must_equal 1
      OnlineOrder.find(100).id.must_equal 100
    end

    it "The customer is present" do
      OnlineOrder.find(1).customer.must_be_instance_of Grocery::Customer
    end

    it "The status is present" do
      OnlineOrder.find(1).status.must_be_kind_of Symbol
    end

    it "Raises an error for an order that doesn't exist" do
      proc {OnlineOrder.find(150)}.must_raise ArgumentError
    end
  end # DESCRIBE

  describe "OnlineOrder.find_by_customer" do
    it "Returns an array of online orders for a specific customer ID" do
      OnlineOrder.find_by_customer(25).must_be_kind_of Array
    end

    it "The online orders are present" do
      OnlineOrder.find_by_customer(25).each do |order|
        order.must_be_instance_of OnlineOrder
      end
    end
  end
end
