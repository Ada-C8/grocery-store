require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/online_order'
require_relative '../lib/order'
require 'csv'

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new


# TODO: uncomment the next line once you start wave 3
# require_relative '../lib/online_order'
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
       online_order = Grocery::OnlineOrder.new("3", {apple: 2, pear: 3}, "1", "Paid")
      online_order.must_be_kind_of Grocery::Order
    end

    it "Can access Customer object" do
      # TODO: Your test code here!
      online_order = Grocery::OnlineOrder.new("3", {apple: 2, pear: 3}, "1", "Paid")
      # online_order.must_respond_to :customer_id
      online_order.customer_id.must_equal "1"
    end

    it "Can access the online order status" do
      # TODO: Your test code here!
      online_order = Grocery::OnlineOrder.new("3", {apple: 2, pear: 3}, "1", "Paid")
      online_order.status.must_equal "Paid"
    end
  end

  describe "#total" do
    it "Adds a shipping fee" do
      # TODO: Your test code here!
      online_order = Grocery::OnlineOrder.new("3", {apple: 2, pear: 3}, "1", "Paid")
      online_order.total.must_equal ((5 + (5 * 0.075)).round(2) + 10)
    end

    it "Doesn't add a shipping fee if there are no products" do
      # TODO: Your test code here!
      online_order = Grocery::OnlineOrder.new("3", {}, "1", "Paid")
      online_order.total.must_equal 0
    end
  end

  describe "#add_product" do
    it "Does not permit action for processing statuses" do
      # TODO: Your test code here!
      online_order = Grocery::OnlineOrder.new("3", {apple: 2, pear: 3}, "1", "processing")
      proc {online_order.add_product}.must_raise ArgumentError
      # proc {Grocery::Order.find(yay_orders.length + 1)}.must_raise ArgumentError
    end #processing

    it "Does not permit action for shipped statuses" do
      online_order = Grocery::OnlineOrder.new("3", {apple: 2, pear: 3}, "1", "shipped")
      proc {online_order.add_product}.must_raise ArgumentError
    end #shipped

    it "Does not permit action for completed statuses" do
      online_order = Grocery::OnlineOrder.new("3", {apple: 2, pear: 3}, "1", "completed")
      proc {online_order.add_product}.must_raise ArgumentError
    end #completed

    it "Permits action for pending satuses" do
      online_order = Grocery::OnlineOrder.new("3", {apple: 2, pear: 3}, "1", "pending")
      online_order.add_product("kiwi", 5).must_equal true
    end

    it "Permits action for pending satuses" do
      online_order = Grocery::OnlineOrder.new("3", {apple: 2, pear: 3}, "1", "paid")
      online_order.add_product("kiwi", 5).must_equal true
    end

  end #describe "#add_product" do

  describe "OnlineOrder.all" do
    # TODO: Your test code here!
    # Useful checks might include:
    #   - OnlineOrder.all returns an array
    #   - Everything in the array is an Order
    #   - The number of orders is correct
    #   - The customer is present
    #   - The status is present
    # Feel free to split this into multiple tests if needed
    it "Returns an array of all online orders" do
      Grocery::OnlineOrder.all.must_be_kind_of Array
    end #it "Returns an array ....

    it "Everything in the array is an Order" do
      test = Grocery::OnlineOrder.all
      test.length.times do |i|
        test[i].must_be_kind_of Grocery::Order
      end #.times
    end #it "Everything in the array is an Order" do

    it "will have the right number of orders in the array" do
      all_online_orders = []
      CSV.open("support/online_orders.csv").each do |line|
        all_online_orders << line
      end

      Grocery::OnlineOrder.all.length.must_equal all_online_orders.length
    end #it "will have the right number of orders in the array" do

    it "will have the customer present" do
      Grocery::OnlineOrder.all[0].must_respond_to :customer_id
    end #it "will have the customer present" do

    it "will have the status present" do
      Grocery::OnlineOrder.all[0].must_respond_to :status
    end #it "will have the customer present" do
  end #describe "OnlineOrder.all" do

  describe "OnlineOrder.find" do

    it "Can find the first order from the CSV" do
      first_order = CSV.open("support/online_orders.csv", 'r'){ |csv| csv.first }
      order_products = {}
      products = first_order[1].split(";")
      products.each do |item_price|
        product_then_price = item_price.split(":")
        order_products[product_then_price[0]] = product_then_price[1].to_f
      end
      test_hash = {first_order[0] => order_products}

      Grocery::OnlineOrder.all
      test = Grocery::OnlineOrder.find("1")

      test.products.must_equal test_hash[first_order[0]]

    end #"Can find the first order from the CSV" do

    it "Can find the last order from the CSV" do

      all_orders = []
      CSV.open("support/online_orders.csv", 'r').each do |line|
        id = line[0]

        order_products = {}
        products_split = line[1].split(';')

        products_split.each do |item_price|
          product_price = item_price.split(':')
          order_products[product_price[0]] = product_price[1].to_f
        end
        products = order_products
        customer_id = line[2]
        status = line[3]
        all_orders << Grocery::OnlineOrder.new(id, products, customer_id, status)
      end


      Grocery::OnlineOrder.all
      test = Grocery::OnlineOrder.find(all_orders.length)

      #Not producing the same list of products....
      test.products.must_equal all_orders[-1].products
    end #"Can find the last order from the CSV"

    it "must return only one order" do
    end #"must return only one order"

    it "Raises an error for an order that doesn't exist" do
    end #"Raises an error for an order that doesn't exist"

  end #describe "OnlineOrder.find" do


  describe "OnlineOrder.find_by_customer" do
    it "Returns an array of online orders for a specific customer ID" do
      # TODO: Your test code here!
    end
  end
end
