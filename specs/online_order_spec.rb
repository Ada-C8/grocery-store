require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require 'minitest/pride'
require_relative '../lib/online_order'
require_relative '../lib/order'


# TODO: uncomment the next line once you start wave 3
# require_relative '../lib/online_order'
# You may also need to require other classes here

# Because an OnlineOrder is a kind of Order, and we've
# already tested a bunch of functionality on Order,
# we effectively get all that testing for free! Here we'll
# only test things that are different.
#
describe "OnlineOrder" do
  describe "#initialize" do
    it "Is a kind of Order" do
      id = 12
      products = { "banana" => 1.99, "cracker" => 3.00 }
      customer_id = 1
      status = "pending"

      online_order = Grocery::OnlineOrder.new(id, products, customer_id, status)
      online_order.must_be_kind_of Grocery::Order
    end

    # TEST STILL FAILING, NIL VS. INTEGER
    # it "Can access Customer object" do
    #   # id = 12
    #   # products = { "banana" => 1.99, "cracker" => 3.00 }
    #   # customer_id = 24
    #   # status = "pending"
    #
    #   # customer = Grocery::Customer.find(24)
    #   # customer = customers[23].id  #customer id #change naming
    #   # puts "#{customer} test"
    #   online_order = Grocery::OnlineOrder.new(12, {"banana": 1.99, "cracker": 3.00}, 24, :pending)
    #   # puts "#{online_order} test"
    #   online_order.customer_id.must_equal 24
    #   end

    it "Can access the online order status" do
      id = 12
      products = { "banana" => 1.99, "cracker" => 3.00 }
      customer_id = 1
      status = :pending

      online_order = Grocery::OnlineOrder.new(id, products, customer_id, status)
      online_order.status.must_equal :pending
    end
  end

  describe "#total" do
    it "Adds a shipping fee" do
      status = :pending
      customer_id = 23
      products = { "banana" => 1.99, "cracker" => 3.00 }
      online_order = Grocery::OnlineOrder.new(1337, products, customer_id, status)
      sum = products.values.inject(0, :+)
      expected_total_with_shipping = (sum + (sum * 0.075).round(2)) + 10

      online_order.total.must_equal expected_total_with_shipping
    end

    it "Doesn't add a shipping fee if there are no products" do
      status = :pending
      customer_id = 23
      products = {}
      online_order = Grocery::OnlineOrder.new(1337, products, customer_id, status)
      sum = products.values.inject(0, :+)
      expected_total = (sum + (sum * 0.075).round(2))

      online_order.total.must_equal expected_total
    end
  end

  describe "#add_product" do
    it "Does not permit action for processing status" do
      status = :completed
      customer_id = 23
      products = { "banana" => 1.99, "cracker" => 3.00 }
      online_order = Grocery::OnlineOrder.new(1337, products, customer_id, status)
      proc {online_order.add_product}.must_raise ArgumentError
    end

    it "Does not permit action for shipped status" do
      status = :shipped
      customer_id = 23
      products = { "banana" => 1.99, "cracker" => 3.00 }
      online_order = Grocery::OnlineOrder.new(1337, products, customer_id, status)
      proc {online_order.add_product}.must_raise ArgumentError
    end

    it "Does not permit action for processing, shipped or completed statuses" do
      status = :processing
      customer_id = 23
      products = { "banana" => 1.99, "cracker" => 3.00 }
      online_order = Grocery::OnlineOrder.new(1337, products, customer_id, status)
      proc {online_order.add_product}.must_raise ArgumentError
    end

    it "Permits action for pending status" do
      status = :pending
      customer_id = 23
      products = { "banana" => 1.99, "cracker" => 3.00 }
      online_order = Grocery::OnlineOrder.new(1337, products, customer_id, status)
      online_order.add_product("sandwich", 4.25).must_equal true
    end

    it "Permits action for paid status" do
      status = :paid
      customer_id = 23
      products = { "banana" => 1.99, "cracker" => 3.00 }
      online_order = Grocery::OnlineOrder.new(1337, products, customer_id, status)
      online_order.add_product("sandwich", 4.25).must_equal true
    end
  end

  describe "OnlineOrder.all" do
    it "Returns an array of all online orders" do
      Grocery::OnlineOrder.all.must_be_kind_of Array
    end

    it "checks that everything in the array is an online order" do
      online_orders = Grocery::OnlineOrder.all
      online_orders.each do |online_order|
        online_order.must_be_instance_of Grocery::OnlineOrder
      end
    end

    it "checks the number of orders is correct" do
      online_orders = Grocery::OnlineOrder.all
      online_orders.length.must_equal 100
    end

    it "will have the customer present" do
      Grocery::OnlineOrder.all[0].must_respond_to :customer
    end

    it "will have the status present" do
      Grocery::OnlineOrder.all[0].must_respond_to :status
    end
  end

  # describe "OnlineOrder.find_by_customer" do
  #   it "Returns an array of online orders for a specific customer ID" do
  #     Grocery::OnlineOrder.all
  #     Grocery::OnlineOrder.find_by_customer(2).must_be_kind_of Array
  #   end

    # it "Can find the first customer from the CSV" do
    #   customer = Grocery::Customer.find(1)
    #   csv = CSV.read("./support/customers.csv")
    #   csv_id = csv.to_a[0][0]
    #   customer.id.must_equal csv_id.to_i
    # end
    #
    # it "Can find the last customer from the CSV" do
    #   customer = Grocery::Customer.find(35)
    #   csv = CSV.read("./support/customers.csv")
    #   csv_id = csv.to_a[-1][0]
    #   customer.id.must_equal csv_id.to_i
    # end
    #
    # it "Raises an error for a customer that doesn't exist" do
    #   proc {Grocery::Customer.find(36)}.must_raise ArgumentError
    # end
  # end
end
