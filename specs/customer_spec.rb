require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'

require_relative '../lib/customer'

describe "Customer" do
  describe "#initialize" do
    it "Takes an ID, email and address info" do
      id = 1337
      email = "person@gmail.com"
      address_info = {
      address1: "123 sesame st",
      city: "seattle",
      state: "WA",
      zip: "123456"}
      new_customer = Grocery::Customer.new(id, email, address_info)

      new_customer.must_respond_to :id
      new_customer.must_respond_to :email
      new_customer.must_respond_to :address_info

      new_customer.id.must_be_kind_of Integer # => does this have to be the case?
      new_customer.id.must_equal id
      new_customer.email.must_equal  email
      new_customer.address_info.must_equal address_info

    end
  end

  describe "Customer.all" do
    it "Customer.all returns an array" do
      result = Grocery::Customer.all
      result.must_be_instance_of Array
    end
    it "Everything in the array is a customer" do
      result = Grocery::Customer.all
      result.each do |element|
        element.must_be_instance_of Grocery::Customer
      end
      # result[0].must_be_instance_of Grocery::Customer
    end
    it "The number of order is correct" do
      result = Grocery::Customer.all
      result.length.must_equal 35
    end
    it "The ID, email address of the first customer match CSV" do
      result = Grocery::Customer.all
      expected_first_customer = result[0]
      expected_first_customer.id.must_equal "1"
      expected_first_customer.email.must_equal "leonard.rogahn@hagenes.org"
    end
    it "The ID, email address of the last customer match CSV" do
      result = Grocery::Customer.all
      expected_last_customer = result[-1]
      expected_last_customer.id.must_equal "35"
      expected_last_customer.email.must_equal "rogers_koelpin@oconnell.org"

    end
  end # => end customers.all

  describe "Customer.find" do
    it "Can find the first customer from the CSV" do
      result = Grocery::Customer.find("1")
      all_customers = Grocery::Customer.all
      result.id.must_equal all_customers[0].id
      result.email.must_equal all_customers[0].email
      result.address_info.must_equal all_customers[0].address_info

      result.id.must_equal "1"
      result.email.must_equal "leonard.rogahn@hagenes.org"




    end

    it "Can find the last customer from the CSV" do
      result = Grocery::Customer.find("35")
      all_customers = Grocery::Customer.all
      result.id.must_equal all_customers[-1].id
      result.email.must_equal all_customers[-1].email
      result.address_info.must_equal all_customers[-1].address_info

      result.id.must_equal "35"
      result.email.must_equal "rogers_koelpin@oconnell.org"
    end

    it "Raises an error for a customer that doesn't exist" do
      proc {Grocery::Customer.find(10000)}.must_raise ArgumentError
    end
  end
end
