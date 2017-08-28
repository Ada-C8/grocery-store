require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'

# TODO: uncomment the next line once you start wave 3
require_relative '../lib/online_order'
require_relative '../lib/order'
require_relative '../lib/customer'
# You may also need to require other classes here

# Because an OnlineOrder is a kind of Order, and we've
# already tested a bunch of functionality on Order,
# we effectively get all that testing for free! Here we'll
# only test things that are different.

describe "WAVE 3: OnlineOrder" do
  describe "#initialize" do
    it "Is a kind of Order" do
      # Check that an OnlineOrder is in fact a kind of Order
      # Instatiate your OnlineOrder here
      online_order = Grocery::OnlineOrder.new("a", "b", "c", "d")
      online_order.must_be_kind_of Grocery::Order
      #online_order.id.must_equal "a"
    end

    it "Can access Customer object" do
      online_orders = Grocery::OnlineOrder.all
      online_orders[0].customer.id.must_equal "25"
    end

    it "Can access the online order status" do
      online_orders = Grocery::OnlineOrder.all
      online_orders[0].order_status.must_equal "complete"
    end
  end

#SKIPPED OVER THIS! GO BACK TO IT
  xdescribe "#total" do
    it "Adds a shipping fee" do
      online_orders = Grocery::OnlineOrder.all
      online_orders[0].total.must equal 168.77
    end

    it "Doesn't add a shipping fee if there are no products" do
      # TODO: Your test code here!
    end
  end

  describe "#add_product" do
    it "Does not permit action for processing, shipped or completed statuses" do
      online_orders = Grocery::OnlineOrder.all

      #order #3 is processing
      proc {online_orders[2].add_product.must_raise ArgumentError}
      #order #5 is shipped
      proc {online_orders[4].add_product.must_raise ArgumentError}
      #order #20 is complete
      proc {online_orders[19].add_product.must_raise ArgumentError}
    end

    it "Permits action for pending and paid statuses" do
      online_orders = Grocery::OnlineOrder.all

      #Order #11 is pending
      online_orders[10].add_product("sardines", 24.50).must_equal true
      #Order #22 is paid
      online_orders[21].add_product("sardines", 24.50).must_equal true
    end
  end

  describe "OnlineOrder.all" do
    it "Returns an array of all online orders" do
      # TODO: Your test code here!
      # Useful checks might include:
      #   - OnlineOrder.all returns an array
      it "Returns an array object" do
        online_orders = Grocery::OnlineOrder.all
        online_orders.must_be_kind_of Array #or Array < Object
      end
      #   - Everything in the array is an Order
      it "Everything in the array is an Order" do
        online_orders = Grocery::OnlineOrder.all
        online_orders.must_be_kind_of Grocery::Order
      end
      #   - The number of orders is correct
      it "Returns the correct number of orders" do
        online_orders = Grocery::OnlineOrder.all
        online_orders.length.must_equal 100
      end
      #   - The customer is present
      it "Returns an object for the customer" do
        online_orders = Grocery::OnlineOrder.all
        online_orders[1].customer.wont_be_nil
      end

      #   - The status is present
      it "Returns a value for the order status" do
      online_orders = Grocery::OnlineOrder.all
      online_orders[1].order_status.wont_be_nil
      end

    end
  end

  describe "OnlineOrder.find_by_customer" do
    it "Returns an array of online orders for a specific customer ID" do
      online_orders = Grocery::OnlineOrder.all
      online_orders.find("100").must_be_kind_of Array

      ##<Grocery::OnlineOrder:0x007fe0fb0a89b0 @id="100", @products={"Amaranth"=>83, "Smoked Trout"=>70, "Cheddar"=>5}, @customer=#<Grocery::Customer:0x007fe0fb07b5a0 @id="20", @email="jerry@ferry.com", @address="90842 Amani Common, Weissnatfurt, TX, 24108">, @order_status="pending">
    end
  end
end
