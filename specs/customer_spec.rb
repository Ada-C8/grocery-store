require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'

# TODO: uncomment the next line once you start wave 3
require_relative '../lib/customer'

describe "Customer" do
  describe "#initialize" do
    it "Takes an ID, email and address info" do
      test_customer = Grocery::Customer.new(1, "email@address.com", "address")
      test_customer.id.must_be_kind_of Integer
      test_customer.email.must_be_kind_of String
      test_customer.address.must_be_kind_of String
    end
  end

  describe "Customer.all" do

    before do
      @test_all_method = Grocery::Customer.all
    end

    #Customer.all returns an array
    it "Returns an array of all customers" do
      @test_all_method.must_be_kind_of Array
    end

    # Everything in the array is a Customer
    it "Everthing in the array is a Customer" do
      @test_all_method[0].must_be_kind_of Grocery::Customer
      @test_all_method[20].must_be_kind_of Grocery::Customer
    end

    # the number of orders is correct
    it "The number of orders is correct" do
      @test_all_method.length.must_equal 35
      @test_all_method.length.must_equal (@test_all_method[-1].id)
      # TYPO? NUMBER OF ORDERS? OR NUMBER OF CUSTOMERS?
    end

    # The ID, email address of the first and last customer match what's in the CSV file
    it "The ID and email address of the first and last customer match what's in the CSV file" do
      @test_all_method[0].id.must_equal 1
      @test_all_method[34].id.must_equal 35
      @test_all_method[0].email.must_equal "leonard.rogahn@hagenes.org"
      @test_all_method[34].email.must_equal "rogers_koelpin@oconnell.org"
    end
  end

  describe "Customer.find" do

    before do
      @test_all_method = Grocery::Customer.all
    end

    it "Can find the first customer from the CSV" do
      @test_find_method = Grocery::Customer.find(1)

      @test_find_method.must_be_kind_of Grocery::Customer
      @test_find_method.must_equal (@test_all_method[0])
    end

    it "Can find the last customer from the CSV" do
      @test_find_method = Grocery::Customer.find(35)

      @test_find_method.must_be_kind_of Grocery::Customer
      @test_find_method.must_equal (@test_all_method[34])
    end

    it "Raises an error for a customer that doesn't exist" do
      proc {Grocery::Customer.find(36)}.must_raise ArgumentError
      proc {Grocery::Customer.find(-1)}.must_raise ArgumentError
      proc {Grocery::Customer.find(0)}.must_raise ArgumentError
    end
  end
end
