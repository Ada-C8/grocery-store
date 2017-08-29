require 'csv'

require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'

require_relative '../lib/customer'

describe "Customer" do
  describe "#initialize" do
    it "Takes an ID, email and address info" do
      id = 1337
      email = "john@johndoe.org"
      address = "1900 E. Blue Street, Seattle, WA 98101"
      customer = Grocery::Customer.new(id, email, address)

      customer.must_respond_to :id
      customer.id.must_equal id
      customer.id.must_be_kind_of Integer

      customer.must_respond_to :email
      customer.email.must_be_kind_of String
      customer.address.must_be_kind_of String
    end
  end

  describe "Customer.all" do
    it "Returns an array of all customers" do

      Grocery::Customer.all.must_be_kind_of Array
    end

    #   - Everything in the array is a Customer
    it "Elements in array are all instances of Customer" do
      Grocery::Customer.all.each do |customer|
        customer.must_be_instance_of Grocery::Customer
      end
    end

    #   - The number of orders is correct
    it "Number of orders is correct" do
      Grocery::Customer.all.length.must_equal 35 #CHECK CSV file for this
    end

    #   - The ID, email address of the first and last customer match what's in the CSV file
    it "ID and email address of first customer matches with CSV file" do
      Grocery::Customer.all[0].id.must_equal 1
      Grocery::Customer.all[0].email.must_equal "leonard.rogahn@hagenes.org"
    end

    it "ID and email address of last customer matches with CSV file" do
      Grocery::Customer.all[34].id.must_equal 35
      Grocery::Customer.all[34].email.must_equal "rogers_koelpin@oconnell.org"
    end
  end

  before do
    @customers = Grocery::Customer.all
  end

  describe "Customer.find" do  ## Be careful with find - might try using Ruby's find instead of mine!
    it "Can find the first customer from the CSV" do
      Grocery::Customer.find(1).id.must_equal @customers[0].id
    end

    it "Can find the last customer from the CSV" do
      Grocery::Customer.find(35).id.must_equal @customers[34].id
    end

    it "Raises an error for a customer that doesn't exist" do
      proc {Grocery::Customer.find(105)}.must_raise ArgumentError
    end
  end
end
