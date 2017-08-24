require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'

# TODO: uncomment the next line once you start wave 3
require_relative '../lib/online-order'
require_relative '../lib/order'
require_relative '../lib/customer'
# You may also need to require other classes here

# adding for color
reporter_options = { color: true }
Minitest::Reporters.use! Minitest::Reporters::DefaultReporter.new(reporter_options)

# Because an OnlineOrder is a kind of Order, and we've
# already tested a bunch of functionality on Order,
# we effectively get all that testing for free! Here we'll
# only test things that are different.

describe "OnlineOrder" do
  describe "#initialize" do
    before do
      @customer = Grocery::Customer.new(1, "leonard.rogahn@hagenes.org", ["71596 Eden Route", "Connellymouth", "LA", "98872-9105"])
      @online_order = Grocery::OnlineOrder.new(1, { "Almonds" => 4.00 }, @customer)
    end

    it "Is a kind of Order" do
      # Check that an OnlineOrder is in fact a kind of Order
      # Instatiate your OnlineOrder here
      @online_order.must_be_kind_of Grocery::Order
    end

    it "Can access Customer object" do
      expected_id = 1
      expected_email = "leonard.rogahn@hagenes.org"
      expected_address = ["71596 Eden Route", "Connellymouth", "LA", "98872-9105"]

      @online_order.customer.id.must_equal expected_id
      @online_order.customer.email.must_equal expected_email
      @online_order.customer.delivery_address.must_equal expected_address
    end

    it "Can access the online order status" do
      # test default status
      expected_status = :pending
      @online_order.status.must_equal expected_status

      # change status and test
      new_status = :shipped
      @online_order.status = new_status
      @online_order.status.must_equal new_status
    end
  end

  describe "#total" do
    before do
      @customer = Grocery::Customer.new(1, "leonard.rogahn@hagenes.org", ["71596 Eden Route", "Connellymouth", "LA", "98872-9105"])
      @products1 = { "Almonds" => 4.00 }
      @products2 = { "Almonds" => 4.00, "Milk" => 4.65 }
    end

    it "Adds a shipping fee" do
      online_order1 = Grocery::OnlineOrder.new(1, @products1, @customer)
      expected_total1 = (4.00 * 1.075 + 10).round(2)

      online_order2 = Grocery::OnlineOrder.new(2, @products2, @customer)
      expected_total2 = ((4.00 + 4.65) * 1.075 + 10).round(2)

      online_order1.total.must_equal expected_total1
      online_order2.total.must_equal expected_total2
    end

    it "Doesn't add a shipping fee if there are no products" do
      online_order = Grocery::OnlineOrder.new(2, {}, @customer)
      online_order.total.must_equal 0
    end
  end

  describe "#add_product" do
    before do
      customer = Grocery::Customer.new(1, "leonard.rogahn@hagenes.org", ["71596 Eden Route", "Connellymouth", "LA", "98872-9105"])
      @online_order = Grocery::OnlineOrder.new(1, { "Almonds" => 4.00 }, customer, :processing)
    end
    it "Does not permit action for processing, shipped or completed statuses" do
      new_product_name = "Milk"
      new_product_price = 4.65

      # should raise error
      # testing processing
      proc { @online_order.add_product(new_product_name, new_product_price) }.must_raise ArgumentError

      # testing shipped
      @online_order.status = :shipped
      proc { @online_order.add_product(new_product_name, new_product_price) }.must_raise ArgumentError

      # testing completed
      @online_order.status = :completed
      proc { @online_order.add_product(new_product_name, new_product_price) }.must_raise ArgumentError
    end

    it "Permits action for pending and paid statuses" do
      # testing pending
      product_list1 = { "Almonds" => 4.00, "Milk" => 4.65 }
      product_list2 = { "Almonds" => 4.00, "Milk" => 4.65, "Banana" => 0.59 }

      @online_order.status = :pending
      added = @online_order.add_product("Milk", 4.65)
      added.must_equal true
      @online_order.products.must_equal product_list1

      @online_order.status = :paid
      added = @online_order.add_product("Banana", 0.59)
      added.must_equal true
      @online_order.products.must_equal product_list2
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
    end
  end

  describe "OnlineOrder.find_by_customer" do
    it "Returns an array of online orders for a specific customer ID" do
      # TODO: Your test code here!
    end
  end
end
