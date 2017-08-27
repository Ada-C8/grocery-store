require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'

# TODO: uncomment the next line once you start wave 3
require_relative '../lib/online_order'
require_relative '../lib/customer'

# You may also need to require other classes here

# Because an OnlineOrder is a kind of Order, and we've
# already tested a bunch of functionality on Order,
# we effectively get all that testing for free! Here we'll
# only test things that are different.

describe "OnlineOrder" do
  describe "#initialize" do
    it "Is a kind of Order" do
      # Check that an OnlineOrder is in fact a kind of Order
      # Instatiate your OnlineOrder here
      # online_order = Grocery::OnlineOrder.new(Grocery::Customer.new("123","sgash@email.com","122323"))
      online_order = Grocery::OnlineOrder.new(1234, { "banana" => 1.99, "cracker" => 3.00 },
      Grocery::Customer.new("123","sgash@email.com","122323"), :pending)

      online_order.must_be_kind_of Grocery::Order
      online_order.must_be_kind_of Grocery::OnlineOrder
    end

    it "Can access Customer object" do
      # online_order = Grocery::OnlineOrder.new(Grocery::Customer.new("123","sgash@email.com","122323"))
      online_order = Grocery::OnlineOrder.new(1234, { "banana" => 1.99, "cracker" => 3.00 },
      Grocery::Customer.new("123","sgash@email.com","122323"), :pending)

      online_order.customer.must_be_kind_of Grocery::Customer
    end

    it "Can access the online order status" do
      # online_order = Grocery::OnlineOrder.new(Grocery::Customer.new("123","sgash@email.com","122323"),:pending )
      online_order = Grocery::OnlineOrder.new(1234, { "banana" => 1.99, "cracker" => 3.00 },
      Grocery::Customer.new("123","sgash@email.com","122323"), :pending)
      online_order.status.must_equal :pending
    end
  end

  describe "#total" do
    it "Adds a shipping fee" do # def initialize (id, products, customer, status = :pending
      online_order = Grocery::OnlineOrder.new(1234, { "banana" => 1.99, "cracker" => 3.00 },
      Grocery::Customer.new("123","sgash@email.com","122323"), :pending)

      prev_total =  Grocery::Order.new(231,{ "banana" => 1.99, "cracker" => 3.00 })
      online_order.total.must_equal prev_total.total + 10
    end

    it "Doesn't add a shipping fee if there are no products" do
      online_order = Grocery::OnlineOrder.new(1234, { "banana" => 1.99, "cracker" => 3.00 },
      Grocery::Customer.new("123","sgash@email.com","122323"), :pending)
      prev_total =  Grocery::Order.new(231,{ "banana" => 1.99, "cracker" => 3.00 })
      if online_order.total == 0
        online_order.total.must_equal prev_total
      end


    end
  end

  describe "#add_product" do
    it "Does not permit action for processing, shipped or completed statuses" do
      online_order = Grocery::OnlineOrder.new(
      1234,
      { "banana" => 1.99, "cracker" => 3.00 },
      Grocery::Customer.new("123","sgash@email.com","122323"),
      :processing)
      proc{online_order.add_product("yogurt", 3.50)}.must_raise ArgumentError

      online_order = Grocery::OnlineOrder.new(
      1234,
      { "banana" => 1.99, "cracker" => 3.00 },
      Grocery::Customer.new("123","sgash@email.com","122323"),
      :shipped)
      proc{online_order.add_product("yogurt", 3.50)}.must_raise ArgumentError

      online_order = Grocery::OnlineOrder.new(
      1234,
      { "banana" => 1.99, "cracker" => 3.00 },
      Grocery::Customer.new("123","sgash@email.com","122323"),
      :complete)
      proc{online_order.add_product("yogurt", 3.50)}.must_raise ArgumentError
    end


    it "Permits action for pending and paid satuses" do
      products = { "banana" => 1.99, "cracker" => 3.00 }
      online_order = Grocery::OnlineOrder.new(
      1234,
      { "banana" => 1.99, "cracker" => 3.00 },
      Grocery::Customer.new("123","sgash@email.com","122323"),
      :pending)
      online_order.add_product("yogurt", 3.50)
      online_order.products.include?("yogurt").must_equal true
    end
  end


  describe "OnlineOrder.all" do
    it "Returns an array of all online orders" do
      # Useful checks might include:
      #   - OnlineOrder.all returns an array
      #   - Everything in the array is an Order
      #   - The number of orders is correct
      #   - The customer is present
      #   - The status is present
      # Feel free to split this into multiple tests if needed
      Grocery::OnlineOrder.all do |s|
        s.must_be_kind_of Grocery::OnlineOrder
      end
    end

    it " The number of orders must be correct" do
      online_order = Grocery::OnlineOrder.all
      online_order.length.must_equal 100
    end

    it "Customer must be present" do
      online_order = Grocery::OnlineOrder.all
      online_order[0].customer.must_be_kind_of Grocery::Customer
      online_order[0].customer.id.must_equal "25"
      online_order[0].customer.email.must_equal "summer@casper.io"
      online_order[0].customer.address.must_equal "66255 D'Amore Parkway,New Garettport,MO,57138"
    end

    it "The status must be present" do
      online_order = Grocery::OnlineOrder.all
      online_order[0].status.must_equal :complete
    end
  end

  describe "OnlineOrder.find_by_customer" do
    it "Returns an array of online orders for a specific customer ID" do
      order = Grocery::OnlineOrder.find_by_customer("25")
      order.id.must_equal "1"
      order.customer.id.must_equal "25"
      expected_products = {"Lobster"=>17.18, "Annatto seed"=>58.38, "Camomile"=>83.21}
      order.products.must_equal expected_products
      order.status.must_equal :complete
    end
  end
end
