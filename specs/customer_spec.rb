require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/customer'

describe "Customer" do
  describe "#initialize" do
    it "Takes an ID, email and address info" do

      id = 112
      email = "bob@aol.com"
      address_1 = "1111 Main Street"
      city = "Smalltown"
      state = "Anywhere"
      zip = "99999"

      customer = Grocery::Customer.new(id, email, address_1, city, state, zip)

      customer.must_respond_to :id
      customer.must_respond_to :email
      customer.must_respond_to :address_1
      customer.must_respond_to :city
      customer.must_respond_to :state
      customer.must_respond_to :zip

      customer.id.must_equal 112
      customer.email.must_equal "bob@aol.com"
      customer.address_1.must_equal "1111 Main Street"
      customer.city.must_equal "Smalltown"
      customer.state.must_equal "Anywhere"
      customer.zip.must_equal "99999"

    end
  end

  describe "Customer.all" do
    it "Returns an array of all customers" do
      all_the_customers = Grocery::Customer.all("./support/customers.csv")
      all_the_customers.must_be_instance_of Array
      all_the_customers.length.must_equal 35

      all_the_customers[0].id.must_equal 1
      all_the_customers[34].id.must_equal 35
      all_the_customers[0].email.must_equal "leonard.rogahn@hagenes.org"
      all_the_customers[34].email.must_equal "rogers_koelpin@oconnell.org"
    end
  end

  describe "Customer.find" do
    it "Can find the first customer from the CSV" do
      Grocery::Customer.find("./support/customers.csv", 1)
    end

    it "Can find the last customer from the CSV" do
      Grocery::Customer.find("./support/customers.csv", 35)    end

      it "Raises an error for a customer that doesn't exist" do
        proc {Grocery::Customer.find("./support/customers.csv", 45)}.must_raise ArgumentError    end
      end
    end
