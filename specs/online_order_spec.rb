require_relative 'spec_helper'
require_relative '../lib/online_order'
require_relative '../lib/customer'
require_relative '../lib/order'
# You may also need to require other classes here

# Because an OnlineOrder is a kind of Order, and we've
# already tested a bunch of functionality on Order,
# we effectively get all that testing for free! Here we'll
# only test things that are different.

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

    it "Can access Customer object" do
      # id = 1337
      # products = { "banana" => 1.99, "cracker" => 3.00 }
      # customer_id = 5
      # status = :pending
      # online_order = Grocery::OnlineOrder.new(id, products, customer_id, status)
      #
      # online_order.get_customer.each do |order|
      #   order.customer_id.must_equal 5
      end
      #
      # Grocery::OnlineOrder.get_customer(5).each do |order|
      #   order.customer_id.must_equal 5

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
  #
  #   it "Doesn't add a shipping fee if there are no products" do
  #     # TODO: Your test code here!
  #   end
  # end
  #
  # describe "#add_product" do
  #   it "Does not permit action for processing, shipped or completed statuses" do
  #     # TODO: Your test code here!
  #   end
  #
  #   it "Permits action for pending and paid satuses" do
  #     # TODO: Your test code here!
  #   end
  # end
  #
  # describe "OnlineOrder.all" do
  #   it "Returns an array of all online orders" do
  #     # TODO: Your test code here!
  #     # Useful checks might include:
  #     #   - OnlineOrder.all returns an array
  #     #   - Everything in the array is an Order
  #     #   - The number of orders is correct
  #     #   - The customer is present
  #     #   - The status is present
  #     # Feel free to split this into multiple tests if needed
  #   end
  # end
  #
  # describe "OnlineOrder.find_by_customer" do
  #   it "Returns an array of online orders for a specific customer ID" do
  #     # TODO: Your test code here!
  #   end
end
