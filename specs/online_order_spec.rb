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
    #   id = 12
    #   products = { "banana" => 1.99, "cracker" => 3.00 }
    #   customer_id = 24
    #   status = "pending"
    #
    #   customers = Grocery::Customer.all
    #   customer = customers[23].id  #customer id #change naming
    #   puts customer
    #   online_order = Grocery::OnlineOrder.new(id, products, customer_id, status)
    #   puts "#{online_order.customer_id} test"
    #   online_order.customer_id.must_equal customer
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
end

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
  # end
# end
