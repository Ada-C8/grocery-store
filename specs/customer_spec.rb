require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/order'

# TODO: uncomment the next line once you start wave 3
require_relative '../lib/customer'

customer_list = "./support/customers.csv"


test_customer = Grocery::Customer.new(0, "email_address", "street", "city", "state", "zip")
list_of_customers = Grocery::Customer.all(customer_list)

describe "Customer" do
  describe "#initialize" do
    it "Takes an ID, email and address info" do
      test_customer.id.must_be_kind_of Integer
      test_customer.email.must_be_kind_of String
      test_customer.address.must_be_kind_of Hash
      test_customer.address.has_key?(:street).must_equal true
      test_customer.address.has_key?(:city).must_equal true
      test_customer.address.has_key?(:state).must_equal true
      test_customer.address.has_key?(:zip).must_equal true
    end
  end

  describe "Customer.all" do

    it "Returns an array of all customers" do
      list_of_customers.must_be_kind_of Array

      list_of_customers.each do |cust|
        cust.must_be_kind_of Grocery::Customer
      end
    end

    it "Creates the proper list from given file" do
      list_of_customers.length.must_equal 35

      list_of_customers.first.id.must_equal 1
      list_of_customers.last.id.must_equal 35
    end

  end
end

describe "Customer.find" do
  it "Returns a customer" do
    Grocery::Customer.find(1, list_of_customers).must_be_kind_of Grocery::Customer
  end
  it "Can find the first customer from the CSV" do
    Grocery::Customer.find(1, list_of_customers).must_equal list_of_customers.first
  end

  it "Can find the last customer from the CSV" do
    Grocery::Customer.find(35, list_of_customers).must_equal list_of_customers.last
  end

  it "Raises an error for a customer that doesn't exist" do
    proc{Grocery::Customer.find(10000000, list_of_customers)}.must_raise RangeError
  end
end
