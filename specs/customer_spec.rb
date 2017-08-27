require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'

# TODO: uncomment the next line once you start wave 3
require_relative '../lib/customer'

describe "Customer" do
  describe "#initialize" do
    it "Takes an ID, email and address info" do
      # TODO: Your test code here!
      id = 6
      customer = Grocery::Customer.new(id, "email", [])

      customer.must_respond_to :id
      customer.id.must_equal id
      customer.id.must_be_kind_of Integer

      customer.must_respond_to :email
      customer.email.must_equal "email"
      customer.email.must_be_kind_of String

      customer.must_respond_to :address
      customer.address.length.must_equal 0
    end
  end

  describe "Customer.all" do
    it "Returns an array of all customers" do
      # TODO: Your test code here!
      # Useful checks might include:
      #   - Customer.all returns an array
      #   - Everything in the array is a Customer
      #   - The number of orders is correct
      #   - The ID, email address of the first and last
      #       customer match what's in the CSV file
      # Feel free to split this into multiple tests if needed
      all_data = Grocery::Customer.all
      all_data.each do |i|
        i.must_be_kind_of Grocery::Customer
      end
    end

    it "Number of orders should be correct" do
      all_data = Grocery::Customer.all
      all_data.length.must_equal 35
    end
    it "Check for ID and email address " do
      all_data = Grocery::Customer.all

      first_customer = all_data[0]
      first_customer.id.must_equal "1"
      first_customer.email.must_equal "leonard.rogahn@hagenes.org"
      # expected_address = "71596 Eden Route,Connellymouth,LA,98872-9105"
      # first_customer.address.must_equal expected_address

      last_customer = all_data[34]
      last_customer.id.must_equal "35"
      last_customer.email.must_equal "rogers_koelpin@oconnell.org"
      # expected_address = "7513 Kaylee Summit,Uptonhaven,DE,64529-2614"
      # last_customer.address.must_equal expected_address
    end
  end

  describe "Customer.find" do
    it "Can find the first customer from the CSV" do
      first_customer = Grocery::Customer.find("1")
      first_customer.id.must_equal "1"
      first_customer.email.must_equal "leonard.rogahn@hagenes.org"
    end

    it "Can find the last customer from the CSV" do
      # TODO: Your test code here!
      last_customer = Grocery::Customer.find("35")
      last_customer.id.must_equal "35"
      last_customer.email.must_equal "rogers_koelpin@oconnell.org"
    end

    it "Raises an error for a customer that doesn't exist" do
      proc {Grocery::Customer.find("39")}.must_raise ArgumentError
    end
  end
end
