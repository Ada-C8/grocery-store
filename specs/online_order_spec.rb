require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'

require_relative '../lib/online_order'
# You may also need to require other classes here

# Because an OnlineOrder is a kind of Order, and we've
# already tested a bunch of functionality on Order,
# we effectively get all that testing for free! Here we'll
# only test things that are different.

describe "OnlineOrder" do
  describe "#initialize" do
    it "Is a kind of Order" do
      # Check that an OnlineOrder is in fact a kind of Order
      email = "leonard.rogahn@hagenes.org"
      address = "71596 Eden Route,Connellymouth,LA,98872-9105"
      customer = Grocery::Customer.new(1, email, address)
      status = :paid
      products = { "banana" => 1.99, "cracker" => 3.00 }
      online_order = OnlineOrder.new(products, 20, customer, status)
      online_order.must_be_kind_of Grocery::Order
    end

    xit "Can access Customer object" do
      id = 1
      email = "leonard.rogahn@hagenes.org"
      address = "71596 Eden Route,Connellymouth,LA,98872-9105"
      customer = Grocery::Customer.new(id, email, address)
      customer.must_be_instance_of Grocery::Customer
    end

    xit "Can access the online order status" do
      id = 1
      email = "leonard.rogahn@hagenes.org"
      address = "71596 Eden Route,Connellymouth,LA,98872-9105"
      status = :paid
      products = { "banana" => 1.99, "cracker" => 3.00 }
      customer = Grocery::Customer.new(id, email, address)
      online_order = OnlineOrder.new(customer, status, products)
      online_order.status.must_equal :paid
    end
  end

  xdescribe "#total" do
    it "Adds a shipping fee" do
      # id = 1
      # email = "leonard.rogahn@hagenes.org"
      # address = "71596 Eden Route,Connellymouth,LA,98872-9105"
      # status = :paid
      # products = { "banana" => 1.99, "cracker" => 3.00 }
      # customer = Grocery::Customer.new(id, email, address)
      # online_order = OnlineOrder.new(customer, status, products)
      # sum = products.values.inject(0, :+)
      # expected_total = sum + (sum * 0.075).round(2)
      #
      # online_order.total.must_equal expected_total + 10.00
    end

    xit "Doesn't add a shipping fee if there are no products" do
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
    end
    it "Everything in the array is an Order" do
    end

    it "The number of total online orders is correct" do
    end

    it "The customer is present" do
    end

    it "The status is present" do
    end
      # Useful checks might include:
      #   - OnlineOrder.all returns an array
      #   - Everything in the array is an Order
      #   - The number of orders is correct
      #   - The customer is present
      #   - The status is present
      # Feel free to split this into multiple tests if needed

  end # DESCRIBE

  xdescribe "OnlineOrder.find_by_customer" do
    it "Returns an array of online orders for a specific customer ID" do
      # TODO: Your test code here!
    end
  end
end
