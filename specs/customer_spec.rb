require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/customer'

# TODO: uncomment the next line once you start wave 3
# require_relative '../lib/customer'

describe "Customer" do
  describe "#initialize" do
    it "Takes an ID, email and address info" do
      test_id = "51"
      test_email = "mystery_person@email.com"
      test_address = "101 Mystery St., Seattle, WA 98115"

      customer = Grocery::Customer.new(test_id, test_email, test_address)

      customer.must_respond_to :id
      customer.id.must_be_kind_of String
      customer.id.must_equal test_id

      customer.must_respond_to :email
      customer.email.must_equal test_email

      customer.must_respond_to :address
      customer.address.must_equal test_address
    end
  end

  describe "Customer.all" do
    it "Returns an array of all customers" do
      customer = Grocery::Customer.all
      customer.must_be_kind_of Array
    end

    it "Everything in the array is a Customer" do
      customer = Grocery::Customer.all
      customer[0].must_be_instance_of Customer

    end

    it "returns the correct number of orders" do
    end

    it "Returns the ID, email and address of the first customer (in the CSV)" do
    end

    it "Returns the ID, email and address of the last customer" do
    end
  end

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
