require 'csv'
require 'pry'
require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/Customer'

# TODO: uncomment the next line once you start wave 3
# require_relative '../lib/customer'

describe "Customer" do
  describe "#initialize" do
    it "Takes an ID, email and address info" do
      # Test inputs for the Customer class initialize
      id = 19
      email = "fake_email@gmail.com"
      address = {
        street_address: "71596 Eden Route",
        city: "Fake City",
        state: "WA",
        zip: "98101"
      }
      # new customer object to test the inputs. must hve with every test.
      customer = Grocery::Customer.new(id, email, address)

      # testing all of 'id' functionality
      # must_respond_to is testing if method exists
      customer.must_respond_to :id
      customer.id.must_equal id
      customer.id.must_be_kind_of Integer
      # testing all of 'email' functionality
      customer.must_respond_to :email
      customer.email.must_equal email
      customer.email.must_be_kind_of String
      # testing all of 'address' functionality
      customer.must_respond_to :address
      customer.address.must_equal address
      customer.address.must_be_kind_of Hash
      customer.address.length.must_equal 4
    end # it "Takes an ID, email and address info"
  end # describe "#initialize"

  describe "Customer.all" do
    it "Returns an array that stores all customer objects" do
      # input: customer object stored in an array
      # output: an array
      # id = 1
      # email = "leonard.rogahn@hagenes.org"
      # address = {
      #   street_address: "71596 Eden Route",
      #   city: "Connellymouth",
      #   state: "LA",
      #   zip: "98872-9105"
      # }
      result = Grocery::Customer.all

      result.must_be_kind_of Array
    end # Array test

    it "Returns customer object" do
      result = Grocery::Customer.all[1]

      result.must_be_kind_of Grocery::Customer
    end # Object test

    it "Returns both first and last customer objects via ID, email, and address" do
      # access the first customer object via its id
      # confirm id is 1
      # access the last customer object via its id
      #confirm id is 35

      result = Grocery::Customer.all

      # ID testing
      # The two statements below are equivalent
      result.first.id.must_equal 1
      result[0].id.must_equal 1

      result.last.id.must_equal 35
      result[-1].id.must_equal 35


      # Email testing
      result.first.email.must_match "leonard.rogahn@hagenes.org"

      result.last.email.must_match "rogers_koelpin@oconnell.org"


      # testing first address
      result.first.address[:street_address].must_match "71596 Eden Route"
      result.first.address[:city].must_match "Connellymouth"
      result.first.address[:state].must_match "LA"
      result.first.address[:zip].must_match "98872-9105"

      #testing last address
      result.last.address[:street_address].must_match "7513 Kaylee Summit"
      result.last.address[:city].must_match "Uptonhaven"
      result.last.address[:state].must_match "DE"
      result.last.address[:zip].must_match "64529-2614"
    end # first and last object test

    it "Returns total number of customer objects, should be 35" do
      result = Grocery::Customer.all.length

      result.must_equal 35
    end # total number object test
  end # describe "Customer.all"

  describe "Customer.find" do
    it "Can find the first customer from the CSV" do
      Grocery::Customer.find(1).id.must_equal 1
      Grocery::Customer.find(1).email.must_match "leonard.rogahn@hagenes.org"
    end

    it "Can find the last customer from the CSV" do
      Grocery::Customer.find(35).id.must_equal 35
      Grocery::Customer.find(35).email.must_match "rogers_koelpin@oconnell.org"
    end

    it "Raises an error for a customer that doesn't exist" do
      proc{Grocery::Customer.find(40)}.must_raise ArgumentError
    end
  end
end
