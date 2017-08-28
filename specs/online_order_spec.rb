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
      # Instatiate your OnlineOrder here
      online_order = Grocery::OnlineOrder.new(8, "b", 25, "d")
      #puts "online_order: #{online_order}"

      ##works checks initialize
      # online_order2 = Grocery::OnlineOrder.new("12", "b", "35")
      #   puts "online_order2: #{online_order2}"
      #   array = []
      #   array << online_order2
      #   array.each do |check|
      #     puts check.id.class
      #     puts check.products.class
      #       cust_id_array = []
      #       cust_id_array << check.customer_id
      #         cust_id_array.each do |check|
      #           puts check.id.class
      #           puts check.email
      #           puts check.address
      #         end
      #     puts check.status
      #   end

      # Check that an OnlineOrder is in fact a kind of Order
      online_order.must_be_kind_of Grocery::Order
    end

    it "Can access Customer object" do
      # TODO: Your test code here!

      online_order2 = Grocery::OnlineOrder.new(12, "b", 35, "g")

      # PRINTS
      #   puts "online_order2: #{online_order2}"
      #   array = []
      #   array << online_order
      #   array.each do |check|
      #     puts "customer id: #{check.customer_id}"
      #       cust_id_array = []
      #       cust_id_array << check.customer_id
      #         cust_id_array.each do |check|
      #           puts check.id
      #           puts check.email
      #           puts check.address
      #         end
      #   end

    end

    it "Can access the online order status" do
      # TODO: Your test code here!
      online_order3 = Grocery::OnlineOrder.new(8, "b", 5, "shipped")
      #puts online_order3
      array = []
      array << online_order3
        array.each do |check|
          print check.status == :shipped
        end
    end
  end

  describe "#total" do
    it "Adds a shipping fee" do
      # TODO: Your test code here!
      order = Grocery::OnlineOrder.new(7, {Eggs:84.23,Watermelon:11.16,Cherries:10.4}, 24, :complete)
      order_plus_shipping = order.total
      puts "Total_3_Products: #{order_plus_shipping}"

    end

    it "Doesn't add a shipping fee if there are no products" do
      # TODO: Your test code here!
      order = Grocery::OnlineOrder.new(7, {}, 24, :complete)
      order_plus_shipping = order.total
      puts "Total_0_Products: #{order_plus_shipping}"

    end
  end

  describe "#add_product" do
    it "Does not permit action for processing, shipped or completed statuses" do
      # TODO: Your test code here!
      order = Grocery::OnlineOrder.new(7, {Eggs:84.23,Watermelon:11.16,Cherries:10.4}, 24, :completed)
      proc {order.add_product("Melons", 45.30)}.must_raise ArgumentError
    end

    it "Permits action for pending and paid statuses" do
      # TODO: Your test code here!
      order = Grocery::OnlineOrder.new(7, {Eggs:84.23,Watermelon:11.16,Cherries:10.4}, 24, :pending)
      order_add_product = order.add_product("Melons", 45.30)
      #puts "Add Product: #{order_add_product}"
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
      all_online_orders = Grocery::OnlineOrder.all


      # #works checks .all method
      # puts all_online_orders
      # a = Grocery::OnlineOrder.all
      #
      # a.each do |check|
      #   puts check.id
      #   puts check.products
      #   array = []
      #   puts check.customer_id
      #   array << check.customer_id
      #   array.each do |cust|
      #     puts cust.id
      #     puts cust.email
      #     puts cust.address
      #   end
      #   puts check.status
      # end

      all_online_orders.must_be_instance_of Array

    end
  end

  describe "OnlineOrder.find_by_customer" do
    it "Returns an array of online orders for a specific customer ID" do
      # TODO: Your test code here!
      a = Grocery::OnlineOrder.find_by_customer(20)
      # puts a
      # a.each do |check|
      #   puts "#{check.customer_id.id}, #{check.id}, #{check.products}, #{check.status}"
      # end
      a.must_be_instance_of Array
    end
  end
end
