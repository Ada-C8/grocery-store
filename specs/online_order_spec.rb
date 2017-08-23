require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'

# TODO: uncomment the next line once you start wave 3
require_relative '../lib/online-order'
require_relative '../lib/order'
require_relative '../lib/customer'
# You may also need to require other classes here

# Because an OnlineOrder is a kind of Order, and we've
# already tested a bunch of functionality on Order,
# we effectively get all that testing for free! Here we'll
# only test things that are different.

describe "OnlineOrder" do
  before do
    @id_order = 3
    @products = { "banana" => 1.99, "cracker" => 3.00 }
    id = 101
    email = "aekitsch@gmail.com"
    address = {
      address_line: "3932 S 284th Pl",
      city: "Auburn",
      state: "WA",
      zip_code: "98001"
    }
    @customer = Grocery::Customer.new(id,email,address)
    @online_order = Grocery::OnlineOrder.new(@id_order, @products, @customer, status: :completed)
  end
  describe "#initialize" do
    it "Is a kind of Order" do
      # Check that an OnlineOrder is in fact a kind of Order
      # Instatiate your OnlineOrder here
      @online_order.must_be_kind_of Grocery::Order
    end

    it "Can access Customer object" do
      @online_order.customer.must_be_instance_of Grocery::Customer
      # @oline_order.customer.id.must_equal 101
      proc{Grocery::OnlineOrder.new(@id_order,@products,"averi", status: :completed)}.must_raise ArgumentError
    end

    it "Can access the online order status" do
      @online_order.status.must_equal :completed
      online_order2 = Grocery::OnlineOrder.new(@id_order,@products,@customer)
      online_order2.status.must_equal :pending
      proc{Grocery::OnlineOrder.new(@id_order,@products,@customer, status: :trying)}.must_raise ArgumentError

    end
  end

  xdescribe "#total" do
    it "Adds a shipping fee" do
      # TODO: Your test code here!
    end

    it "Doesn't add a shipping fee if there are no products" do
      # TODO: Your test code here!
    end
  end

  xdescribe "#add_product" do
    it "Does not permit action for processing, shipped or completed statuses" do
      # TODO: Your test code here!
    end

    it "Permits action for pending and paid satuses" do
      # TODO: Your test code here!
    end
  end

  xdescribe "OnlineOrder.all" do
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

  xdescribe "OnlineOrder.find_by_customer" do
    it "Returns an array of online orders for a specific customer ID" do
      # TODO: Your test code here!
    end
  end
end
