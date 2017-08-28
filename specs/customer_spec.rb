require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'

require_relative '../lib/customer'
require_relative '../lib/order'

describe "Customer" do
  describe "#initialize" do
    it "Takes an ID, email and address info" do
      # tests that id, email, and adress is stored correctly
      id = 1
      email = "test.email.com"
      address = "123 somewhere lane, state, country, zip"
      new_customer = Grocery::Customer.new(id, email, address)

      new_customer.must_respond_to :id
      new_customer.id.must_equal id
      new_customer.id.must_be_kind_of Integer

      new_customer.must_respond_to :email
      new_customer.email.must_equal email
      new_customer.email.must_be_kind_of String

      new_customer.must_respond_to :address
      new_customer.address.must_equal address
      new_customer.address.must_be_kind_of String
    end

    it "Customer matches what's in the CSV file" do
      # opens file and access first customer's address and checks for match
      customers = []
      CSV.open("support/customers.csv", "r").each do |line|
        customers << Grocery::Customer.new(line[0].to_i, line[1], line[2..5].join(", ") )
      end
      customers[0].address.must_equal "71596 Eden Route, Connellymouth, LA, 98872-9105"
    end

  end

  describe "Customer.all" do
    it "Returns an array of all customers" do
      # Customer.all returns an array
      Grocery::Customer.all.must_be_kind_of Array
    end

    it "Everything in the array is a Customer" do
      # each item in array returned by Customer.all is a Customer
      Grocery::Customer.all.each do |item|
        item.must_be_instance_of Grocery::Customer
      end
    end

      it "Correct number of customers" do
        # correct number of customers stored in array
        Grocery::Customer.all.length.must_equal 35
      end
    end

    describe "Customer.find" do
      it "Can find the first customer from the CSV" do
        # first customer has id of 1 and email of "leonard.rogahn@hagenes.org"
        Grocery::Customer.find(1).id.must_equal 1
        Grocery::Customer.find(1).email.must_equal "leonard.rogahn@hagenes.org"
      end

      it "Can find the last customer from the CSV" do
        # last customer has id of 35 and email of rogers_koelpin@oconnell.org
        Grocery::Customer.find(35).email.must_equal "rogers_koelpin@oconnell.org"
        Grocery::Customer.find(35).id.must_equal 35
      end

      it "Raises an error for a customer that doesn't exist" do
        # tells user this is an invalid id
        proc { Grocery::Customer.find(36) }.must_raise ArgumentError
      end
    end
  end
