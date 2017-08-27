require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'

# TODO: uncomment the next line once you start wave 3
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
      online_order = OnlineOrder.new(19, {cheese:5.00, bacon:5.00}, Grocery::Customer.new(12, "amy@this.com", "123 Fake St., Dayton, Ohio, 12121"), :pending)
      online_order.must_be_kind_of Grocery::Order
    end #kind of order

    it "Can access Customer object" do
      online_order = OnlineOrder.new(19, {cheese:5.00, bacon:5.00}, Grocery::Customer.new(12, "amy@this.com", "123 Fake St., Dayton, Ohio, 12121"), :pending)
      online_order.customer_info.must_be_kind_of Grocery::Customer
    end #access Customer Object

    it "Can access the online order status" do
      online_order = OnlineOrder.new(19, {cheese:5.00, bacon:5.00}, Grocery::Customer.new(12, "amy@this.com", "123 Fake St., Dayton, Ohio, 12121"), :pending)
      online_order.must_respond_to :status
      online_order.status.must_equal :pending
    end #access online order status
  end #initialize

  describe "#total" do
    it "Adds a shipping fee" do
      x = OnlineOrder.new(19, {cheese:5.00, bacon:5.00}, Grocery::Customer.new(12, "amy@this.com", "123 Fake St., Dayton, Ohio, 12121"), :pending)
      x.total.must_equal 20.75
    end #add shipping fee

    it "Doesn't add a shipping fee if there are no products" do
      x = OnlineOrder.new(19, {}, Grocery::Customer.new(12, "amy@this.com", "123 Fake St., Dayton, Ohio, 12121"), :pending)
      x.total.must_equal 0
    end #no fee if no products
  end #test total

  describe "#add_product" do
    it "Does not permit action for processing, shipped or completed statuses" do
      # TODO: Your test code here!
    end #all other statuses

    it "Permits action for pending and paid satuses" do
      # TODO: Your test code here!
    end #pending and paid
  end #add_product


  describe "OnlineOrder.all" do
    #   - OnlineOrder.all returns an array
    it "OnlineOrder.all returns an array" do
      order = OnlineOrder.all
      order.must_be_kind_of Array
    end #returns array

    it "Everything in the array is an Order " do
      order = OnlineOrder.all
      order.each do |item|
        item.must_be_instance_of Grocery::Order
      end #each do
    end #everything is an order

     it "The number of orders is correct" do
       order = OnlineOrder.all
       order.length.must_equal 100
     end #number is correct

    it "The customer is present" do
      order = OnlineOrder.all
      order = each do |item|
        item.customer_info.must
    end #customer present


    it "The status is present" do
    end #status present
end #online order all method

describe "OnlineOrder.find_by_customer" do
  it "Returns an array of online orders for a specific customer ID" do
    # TODO: Your test code here!
  end#return an array specific to customer
end #find by customer tests
end #all tests
