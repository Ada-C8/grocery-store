require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/customer'

# TODO: uncomment the next line once you start wave 3
# require_relative '../lib/customer'

describe "Customer" do
  describe "#initialize" do
    it "Takes an ID, email and address info" do
      customer1 = Grocery::Customer.new(105, "person@gmail.com", "232 Ridge Ave")

      customer1.must_be_instance_of Grocery::Customer

    end
  end

  describe "Customer.all" do
    it "Returns an array of all customers" do
      # TODO: Your test code here!
      # Useful checks might include:
      Grocery::Customer.all.must_be_instance_of Array
      Grocery::Customer.all.sample.must_be_instance_of Grocery::Customer
      #   - The number of orders is correct
      Grocery::Customer.all.length.must_be :==, 35
      Grocery::Customer.all.first.id.must_equal 1
      Grocery::Customer.all.first.email.must_match "leonard.rogahn@hagenes.org"

      Grocery::Customer.all.last.id.must_equal 35
      Grocery::Customer.all.last.email.must_match "rogers_koelpin@oconnell.org"
    end
  end

  describe "Customer.find" do
    it "Can find the first customer from the CSV" do
      Grocery::Customer.find(1).must_be_instance_of Grocery::Customer

      Grocery::Customer.find(1).must_be_same_as Grocery::Customer.all.first
    end

    it "Can find the last customer from the CSV" do
      Grocery::Customer.find(35).must_be_instance_of Grocery::Customer

      Grocery::Customer.find(35).must_be_same_as Grocery::Customer.all.last
    end

    it "Raises an error for a customer that doesn't exist" do
      proc {Grocery::Customer.find(36)}.must_raise ArgumentError
    end
  end
end
