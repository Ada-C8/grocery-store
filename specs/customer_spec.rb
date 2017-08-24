require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/customer'

describe "Customer" do
  describe "#initialize" do
    it "Takes an ID, email and address info" do

      test_customer = Grocery::Customer.new(1, "leonard.rogahn@hagenes.org", {address: "71596 Eden Route", city: "Connellymouth", state: "LA", zipcode: "98872-9105"})

      test_customer.must_respond_to :id && :email && :address
      test_customer.id.must_equal 1
      test_customer.id.must_be_kind_of Integer

      address = {:address=>"71596 Eden Route", :city=>"Connellymouth", :state=>"LA", :zipcode=>"98872-9105"}

      test_customer.address.must_equal address
    end # takes info
  end # initialize

  describe "Customer.all" do
    it "Customer.all an array of all customers" do
      customers = Grocery::Customer.all
      customers.must_be_kind_of Array
    end # big returns array

    it "Everything in the array is a Customer" do
      customers = Grocery::Customer.all
      10.times do
        customers[rand(35)].must_be_instance_of Grocery::Customer
      end # everything in array is a Customer

      it "The number of orders is correct (35)" do
        Grocery::Customer.all.length.must_equal 35
      end # number of orders equals 35

      #   - The ID, email address of the first and last
      #       customer match what's in the CSV file
      # Feel free to split this into multiple tests if needed
    end # customer.all

    xdescribe "Customer.find" do
      it "Can find the first customer from the CSV" do
        # TODO: Your test code here!
      end

      it "Can find the last customer from the CSV" do
        # TODO: Your test code here!
      end

      it "Raises an error for a customer that doesn't exist" do
        # TODO: Your test code here!
      end
    end
  end
