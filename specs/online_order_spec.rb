require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'



# TODO: uncomment the next line once you start wave 3
require_relative '../lib/order'
require_relative '../lib/customer'
require_relative '../lib/online_order'

# You may also need to require other classes here

# Because an OnlineOrder is a kind of Order, and we've
# already tested a bunch of functionality on Order,
# we effectively get all that testing for free! Here we'll
# only test things that are different.

describe "OnlineOrder" do
  xdescribe "#initialize" do
    it "Is a kind of Order" do
      # Check that an OnlineOrder is in fact a kind of Order

      # Instatiate your OnlineOrder here
      # online_order =
      # online_order.must_be_kind_of Grocery::OnlineOrder

      order_1 = Grocery::Onlineorder.new(1,[], 39, :paid)
      order_1.must_be_instance_of Grocery::Onlineorder
      order_1.must_be_kind_of Grocery::Onlineorder

    end

    it "Can access Customer object" do
      Grocery::Onlineorder.all
      Grocery::Onlineorder.find(1).customer.email.must_equal "summer@casper.io"

      # Grocery::Onlineorder.find(1).email.must_equal "leonard.rogahn@hagenes.org"

    end

    it "Can access the online order status" do
      # TODO: Your test code here!
      Grocery::Onlineorder.all
      Grocery::Onlineorder.find(1).status.must_equal :complete
      Grocery::Onlineorder.find(100).status.must_equal :pending

    end
  end

  describe "#total" do
    it "Adds a shipping fee" do
      # TODO: Your test code here!

      Grocery::Onlineorder.all
      Grocery::Onlineorder.find(1).total.must_equal 180.68



    end

    it "Doesn't add a shipping fee if there are no products" do
      # TODO: Your test code here!
      Grocery::Onlineorder.all
      Grocery::Onlineorder.find(5).products = []
      Grocery::Onlineorder.find(5).total.must_equal 0

    end
  end

  # describe "#add_product" do
  #   it "Does not permit action for processing, shipped or completed statuses" do
  #     # TODO: Your test code here!
  #   end
  #
  #   it "Permits action for pending and paid satuses" do
  #
  #     # TODO: Your test code here!
  #   end
  # end
  #
  xdescribe "OnlineOrder.all" do
    it "Returns an array of all online orders" do
      # TODO: Your test code here!
      # Useful checks might include:
      #   - OnlineOrder.all returns an array +
      #   - Everything in the array is an Order
      #   - The number of orders is correct +
      #   - The customer is present
      #   - The status is present
      # Feel free to split this into multiple tests if needed

        Grocery::Onlineorder.all.must_be_kind_of Array
        Grocery::Onlineorder.all.length.must_equal 100
        Grocery::Onlineorder.find(1).customer.id.must_equal 25
        Grocery::Onlineorder.find(1).customer.delivery_address.must_equal "66255 D'Amore Parkway,New Garettport,MO,57138"
        Grocery::Onlineorder.find(1).status.must_equal :complete

    end
  end

  xdescribe "OnlineOrder.find_by_customer" do
    it "Returns an array of online orders for a specific customer ID" do
      # TODO: Your test cod here!

      Grocery::Onlineorder.all
      Grocery::Onlineorder.find(1).id.must_equal 1
      Grocery::Onlineorder.find(1).status.must_equal :complete
      Grocery::Onlineorder.find(1).customer.id.must_equal 25


    end
  end
end
