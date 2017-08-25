require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'

# TODO: uncomment the next line once you start wave 3
require_relative '../lib/customer'
require_relative '../lib/order'

describe "Customer" do
  describe "#initialize" do
    it "Takes an ID, email and address info" do
      # TODO: Your test code here!
      id = 1
      email = "test.email.com"
      address = "123 somewhere lane, state, country, zip"
      new_customer = Grocery::Customer.new(id, email, address)
      # new_customer = Grocery::Customer.new(id, email, address)
      new_customer.must_respond_to :id
      new_customer.id.must_equal id
      new_customer.id.must_be_kind_of Integer

      new_customer.must_respond_to :email
      new_customer.email.must_be_kind_of String

      new_customer.must_respond_to :address
      new_customer.address.must_be_kind_of String
    end
  end

  describe "Customer.all" do
    it "Returns an array of all customers" do
      # Customer.all returns an array
      Grocery::Customer.all.must_be_kind_of Array
      # Useful checks might include:
      #   - The number of orders is correct
      #   - The ID, email address of the first and last
      #       customer match what's in the CSV file
      # Feel free to split this into multiple tests if needed
    end

    it "Everything in the array is a Customer" do
      # each item in array returned by Customer.all is a Customer
      Grocery::Customer.all.each do |item|
        item.must_be_instance_of Grocery::Customer
      end
    end

        # it "Number of orders is correct" do
        #   # correct number of orders for sample customer
        #   Customer.all.each do |item|
        #     item.must_be_instance_of Customer
        #   end
        # TODO: in .find test???? + do order check
        # Useful checks might include:
        #   - The number of orders is correct
        #   - The ID, email address of the first and last
        #       customer match what's in the CSV file
        # Feel free to split this into multiple tests if needed


        # it "Returns corret number of orders" do
        #   # each item in array returned by Customer.all is a Customer
        #   Customer.all.each do |item|
        #     item.must_be_instance_of Customer
        #   end

        # Useful checks might include:
        #   - The number of orders is correct
        #   - The ID, email address of the first and last
        #       customer match what's in the CSV file
        # Feel free to split this into multiple tests if needed
        it "Correct number of customers" do
          # correct number of customers stored in array
          Grocery::Customer.all.length.must_equal 35
        end
    end

    describe "Customer.find" do
      it "Can find the first customer from the CSV" do
        # first customer has id of 1
        Grocery::Customer.find(1).id.must_equal 1
      end

      it "Can find the last customer from the CSV" do
        # first customer has id of 1
        Grocery::Customer.find(35).id.must_equal 35
      end

      it "Raises an error for a customer that doesn't exist" do
        # tells user this is an invalid id
        proc { Grocery::Customer.find(36) }.must_raise ArgumentError
      end
    end
  end
