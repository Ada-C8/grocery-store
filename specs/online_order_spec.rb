require_relative 'spec_helper'
require_relative '../lib/online_order'
require_relative '../lib/customer'
require_relative '../lib/order'

describe "OnlineOrder" do
  describe "#initialize" do
    it "Is a kind of Order" do
      id = 1337
      products = { "banana" => 1.99, "cracker" => 3.00 }
      customer_id = 5
      status = :pending
      online_order = Grocery::OnlineOrder.new(id, products, customer_id, status)

      online_order.must_be_kind_of Grocery::OnlineOrder
      online_order.must_be_kind_of Grocery::Order
    end

    # it "Can access Customer object" do
    #   id = 1337
    #   products = { "banana" => 1.99, "cracker" => 3.00 }
    #   customer_id = 5
    #   status = :pending
    #   online_order = Grocery::OnlineOrder.new(id, products, customer_id, status)
    #
    #   online_order.customer_id.must_be_kind_of Grocery::Customer
    #
    #   end

    it "Can access the online order status" do
      id = 1337
      products = { "banana" => 1.99, "cracker" => 3.00 }
      customer_id = 5
      status = :pending
      online_order = Grocery::OnlineOrder.new(id, products, customer_id, status)

      online_order.must_respond_to :status
      online_order.status.must_equal status
      online_order.status.must_be_kind_of Symbol
    end
  end

  describe "#total" do
    it "Adds a shipping fee" do
        id = 1337
        products = { "banana" => 1.99, "cracker" => 3.00 }
        customer_id = 5
        status = :pending
        online_order = Grocery::OnlineOrder.new(id, products, customer_id, status)

        sum = products.values.inject(0, :+)
        expected_total = sum + ((sum * 0.075) + 10).round(2)

        online_order.total.must_equal expected_total
      end
    end

    it "Doesn't add a shipping fee if there are no products" do
      id = 1337
      products = { }
      customer_id = 5
      status = :pending
      online_order = Grocery::OnlineOrder.new(id, products, customer_id, status)

      online_order.total.must_equal 0
    end
  end

  describe "#add_product" do
    it "Does not permit action for processing, shipped or completed statuses" do
      id = 1337
      products = { "banana" => 1.99, "cracker" => 3.00 }
      customer_id = 5
      status = :processing
      online_order = Grocery::OnlineOrder.new(id, products, customer_id, status)

      proc {
        online_order.add_product("salad", 4.25)
      }.must_raise ArgumentError

      id = 1337
      products = { "banana" => 1.99, "cracker" => 3.00 }
      customer_id = 5
      status = :shipped
      online_order = Grocery::OnlineOrder.new(id, products, customer_id, status)

      proc {
        online_order.add_product("salad", 4.25)
      }.must_raise ArgumentError

      id = 1337
      products = { "banana" => 1.99, "cracker" => 3.00 }
      customer_id = 5
      status = :complete
      online_order = Grocery::OnlineOrder.new(id, products, customer_id, status)

      proc {
        online_order.add_product("salad", 4.25)
      }.must_raise ArgumentError
    end

    it "Permits action for pending and paid satuses" do
      id = 1337
      products = { "banana" => 1.99, "cracker" => 3.00 }
      customer_id = 5
      status = :pending
      online_order = Grocery::OnlineOrder.new(id, products, customer_id, status)

      online_order.add_product("sandwich", 4.25)
      online_order.products.include?("sandwich").must_equal true

      id = 1337
      products = { "banana" => 1.99, "cracker" => 3.00 }
      customer_id = 5
      status = :paid
      online_order = Grocery::OnlineOrder.new(id, products, customer_id, status)

      online_order.add_product("sandwich", 4.25)
      online_order.products.include?("sandwich").must_equal true
    end
  end

  describe "OnlineOrder.all" do
    it "Returns an array of all orders" do
      Grocery::OnlineOrder.all.must_be_kind_of Array
    end

    it "Everything in the array is an Order" do
      Grocery::OnlineOrder.all.each do |online_order|
        online_order.must_be_kind_of Grocery::OnlineOrder
      end
    end

    it "the number of orders is correct" do
      Grocery::OnlineOrder.all.length.must_equal 100
    end

    it "the ID and products match the first order in the CSV file" do
      Grocery::OnlineOrder.all.first.id.must_equal 1
      Grocery::OnlineOrder.all.first.products.must_equal("Lobster" => 17.18, "Annatto seed" => 58.38, "Camomile" => 83.21)
      Grocery::OnlineOrder.all.first.customer_id.must_equal 25
      Grocery::OnlineOrder.all.first.status.must_equal :complete


      Grocery::OnlineOrder.all.last.id.must_equal 100
      Grocery::OnlineOrder.all.last.products.must_equal("Amaranth" => 83.81, "Smoked Trout" => 70.6, "Cheddar" => 5.63)
      Grocery::OnlineOrder.all.last.customer_id.must_equal 20
      Grocery::OnlineOrder.all.last.status.must_equal :pending
    end

    describe "OnlineOrder.find" do
      it "Can find the first order from the CSV" do
        online_order = Grocery::OnlineOrder.find(1)

        online_order.must_be_instance_of Grocery::OnlineOrder
        online_order.id.must_equal 1
        online_order.products.must_equal("Lobster" => 17.18, "Annatto seed" => 58.38, "Camomile" => 83.21)
        online_order.customer_id.must_equal 25
        online_order.status.must_equal :complete
      end

      it "Can find the last order from the CSV" do
        online_order = Grocery::OnlineOrder.find(100)

        online_order.must_be_instance_of Grocery::OnlineOrder
        online_order.id.must_equal 100
        online_order.products.must_equal("Amaranth" => 83.81, "Smoked Trout" => 70.6, "Cheddar" => 5.63)
        online_order.customer_id.must_equal 20
        online_order.status.must_equal :pending
    end
    
      it "Raises an error for an online_order that doesn't exist" do
        proc {
          Grocery::OnlineOrder.find(102)
        }.must_raise ArgumentError
      end
    end

  describe "OnlineOrder.find_by_customer" do
    it "Returns an array of online orders for a specific customer ID" do
      Grocery::OnlineOrder.find_by_customer(23).each do |customer|
        customer.customer_id.must_equal 23
      end
    end
  end
end
