require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'

require_relative '../lib/customer'


describe "Customer" do
  describe "#initialize" do
    it "Takes an ID, email and address info" do
      id = 346
      email = "email@gmail.com"
      address = "address"
      customer = Grocery::Customer.new(id, email, address)

      customer.must_respond_to :id
      customer.id.must_equal id
      customer.id.must_be_kind_of Integer

      customer.must_respond_to :email
      customer.email.must_equal "email@gmail.com"
      customer.email.must_be_kind_of String

      customer.must_respond_to :address
      customer.address.must_equal "address"
      customer.address.must_be_kind_of String
    end
  end

  describe "Customer.all" do
    it "Returns an array of all customers" do
      Grocery::Customer.all("support/customers.csv").must_be_kind_of Array
    end

    it "The number of customers is correct" do
      Grocery::Customer.all("support/customers.csv").length.must_equal 35
    end

    it "The ID, email address of the first and last customer match what's in the CSV file" do
      Grocery::Customer.all("support/customers.csv").first.id.must_equal 1
      Grocery::Customer.all("support/customers.csv").first.email.must_equal "leonard.rogahn@hagenes.org"
      Grocery::Customer.all("support/customers.csv").last.id.must_equal 35
      Grocery::Customer.all("support/customers.csv").last.email.must_equal "rogers_koelpin@oconnell.org"
    end

    it "Everything in the array is a Customer" do
      Grocery::Customer.all("support/customers.csv").each do |customer|
        customer.must_be_kind_of Grocery::Customer
      end
    end
  end

  describe "Customer.find" do
    it "Can find the first customer from the CSV" do
      Grocery::Customer.find(1, "support/customers.csv").email.must_equal "leonard.rogahn@hagenes.org"
    end

    it "Can find the last customer from the CSV" do
      Grocery::Customer.find(35, "support/customers.csv").email.must_equal "rogers_koelpin@oconnell.org"
    end

    it "Raises an error for a customer that doesn't exist" do
      proc {Grocery::Customer.find(1000, "support/customers.csv")}.must_raise KeyError
    end
  end
end
