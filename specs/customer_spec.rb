require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/customer'
require 'pry'

describe "Customer" do
  describe "#initialize" do
    it "Takes an ID, email and address info" do

      test_customer = Grocery::Customer.new(1, "leonard.rogahn@hagenes.org", {address: "71596 Eden Route", city: "Connellymouth", state: "LA", zipcode: "98872-9105"})

      test_customer.must_respond_to :customer_id && :email && :address
      test_customer.customer_id.must_equal 1
      test_customer.customer_id.must_be_kind_of Integer

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
      10.times do
        Grocery::Customer.all[rand(35)].must_be_instance_of Grocery::Customer
      end
    end # everything in array is a Customer

    it "The number of orders is correct (35)" do
      Grocery::Customer.all.length.must_equal 35
    end # number of orders equals 35

    it "The ID, email address of the first and last
    customer match what's in the CSV file" do
      test_customer = Grocery::Customer.new(1, "leonard.rogahn@hagenes.org", {address: "71596 Eden Route", city: "Connellymouth", state: "LA", zipcode: "98872-9105"})
      # test_customer = Grocery::Customer.all
      Grocery::Customer.all.first.customer_id.must_equal test_customer.customer_id

      Grocery::Customer.all.first.email.must_equal test_customer.email
    end # id and email match
  end


  describe "Customer.find" do
    it "Can find the first customer from the CSV" do
      Grocery::Customer.find(1).customer_id.must_equal 1
      Grocery::Customer.find(1).email.must_equal "leonard.rogahn@hagenes.org"
    end

    it "Can find the last customer from the CSV" do
      Grocery::Customer.find(35).customer_id.must_equal 35
      Grocery::Customer.find(35).email.must_equal "rogers_koelpin@oconnell.org"
    end

    it "Raises an error for a customer that doesn't exist" do
      error_customer = (Grocery::Customer.all.max_by{|o|o.customer_id}).customer_id + 1

      proc {Grocery::Customer.find(36)}.must_raise ArgumentError
      proc {Grocery::Customer.find(error_customer)}.must_raise ArgumentError
    end
  end
end
