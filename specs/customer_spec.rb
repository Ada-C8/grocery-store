require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'

require_relative '../lib/customer'

describe "Customer" do
  describe "#initialize" do
    it "Takes an ID, email and address info" do
      customer = Grocery::Customer.new(3, "edison.mclaughlin@hyattjohns.co", "96807 Cartwright Points", "North Casper", "MT", 29547)
      customer.must_respond_to :id
      customer.must_respond_to :email
      customer.must_respond_to :address
      customer.must_respond_to :city
      customer.must_respond_to :state
      customer.must_respond_to :zip
    end
  end

  describe "Customer.all" do
    it "Returns an array of all customers" do
      customers = Grocery::Customer.all
      customers.must_be_instance_of Array
      customers.each { |customer| customer.must_be_instance_of Grocery::Customer }
    end

    it "Has the correct number of customers" do
      Grocery::Customer.all.length.must_equal 35
    end

    it "ID and emails of the first and last customers match that in the CSV" do
      first_customer = Grocery::Customer.all[0]
      last_customer = Grocery::Customer.all[-1]

      first_customer.id.must_equal 1
      last_customer.id.must_equal 35

      first_customer.email.must_equal "leonard.rogahn@hagenes.org"
      last_customer.email.must_equal "rogers_koelpin@oconnell.org"
    end
  end

  describe "Customer.find" do
    it "Can find the first customer from the CSV" do
      Grocery::Customer.find(1).id.must_equal 1
    end

    it "Can find the last customer from the CSV" do
      Grocery::Customer.find(35).id.must_equal 35
    end

    it "Raises an error for a customer that doesn't exist" do
      proc { Grocery::Customer.find(105) }.must_raise ArgumentError
    end

    it "Returns an Customer object" do
      Grocery::Customer.find(rand(1..35)).must_be_instance_of Grocery::Customer
    end
  end
end
