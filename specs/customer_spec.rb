require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '/Users/kimberley/ada/week-three/grocery-store/lib/customer.rb'

describe "Customer" do
  describe "#initialize" do
    it "Takes an ID, email and address info" do
      address = {street_address: "123 Fake Street", city: "Brooklyn", state: "NY", zipcode: "11217"}

      customer = Grocery::Customer.new(19, "me@mac.com", {street_address: "123 Fake Street", city: "Brooklyn", state: "NY", zipcode: "11217"})

      customer.must_be_instance_of Grocery::Customer

      customer.must_respond_to :id
      customer.id.must_equal 19
      customer.id.must_be_kind_of Integer

      customer.must_respond_to :email
      customer.email.must_equal "me@mac.com"
      customer.email.must_be_kind_of String

      customer.must_respond_to :address
      customer.address.must_equal address
      customer.address.must_be_kind_of Hash
    end
  end

  describe "Customer.all" do
    it "Returns an array of all customers" do
      Grocery::Customer.all.must_be_instance_of Array
    end

    it "each object in the array is a customer" do
      customer = Grocery::Customer.all[0]
      customer.must_be_instance_of Grocery::Customer

      customer = Grocery::Customer.all[18]
      customer.must_be_instance_of Grocery::Customer

      customer = Grocery::Customer.all[34]
      customer.must_be_instance_of Grocery::Customer
    end

    it "The ID and emails of the first and last customers match what's in the CSV file" do
      customer_one = Grocery::Customer.all[0]
      customer_one.id.must_equal "1"
      customer_one.email.must_equal "leonard.rogahn@hagenes.org"

      customer_two = Grocery::Customer.all[34]
      customer_two.id.must_equal "35"
      customer_two.email.must_equal "rogers_koelpin@oconnell.org"
    end

    it "The number of customers is correct" do
      Grocery::Customer.all.count.must_equal 35
    end
  end

  xdescribe "Customer.find" do
    it "Can find the first customer from the CSV" do
      Grocery::Customer.find(1).must_be_instance_of Grocery::Customer

      Grocery::Customer.find(1).email.must_equal "leonard.rogahn@hagenes.org"
    end

    it "Can find the last customer from the CSV" do
      Grocery::Customer.find(35).must_be_instance_of Grocery::Customer

      Grocery::Customer.find(35).email.must_equal "rogers_koelpin@oconnell.org"
    end

    it "Raises an error for a customer that doesn't exist" do
      proc {Grocery::Customer.find(1000)}.must_raise ArgumentError
      proc {Grocery::Customer.find(0)}.must_raise ArgumentError
      proc {Grocery::Customer.find(-12)}.must_raise ArgumentError
    end
  end
end
