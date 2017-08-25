require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'

require_relative '../lib/customer'

describe "Customer" do
  describe "#initialize" do
    it "Takes an ID, email and address info" do
      id = 1
      email = "leonard.rogahn@hagenes.org"
      address = "71596 Eden Route,Connellymouth,LA,98872-9105"
      customer = Grocery::Customer.new(id, email, address)

      customer.must_respond_to :id
      customer.id.must_equal id
      customer.id.must_be_kind_of Integer

      customer.must_respond_to :email
      customer.email.must_equal email
      customer.email.must_be_kind_of String

      customer.must_respond_to :address
      customer.address.must_equal address
      customer.address.must_be_kind_of String
    end
  end

  describe "Customer.all" do
    it "Returns an array of all customers" do
      Grocery::Customer.all.must_be_kind_of Array
    end

    it "Each index of the array is an instance of Grocery::Customer" do
      Grocery::Customer.all.each do |customer|
        customer.must_be_instance_of Grocery::Customer
      end
    end

    it "The number of customers is correct" do
      Grocery::Customer.all.count.must_equal 35
    end

    # MAKE THIS MORE DYNAMIC
    it "The ID, email address is correct for the first customer in the CSV file" do
      Grocery::Customer.all.first.id.must_equal 1
      Grocery::Customer.all.first.email.must_equal "leonard.rogahn@hagenes.org"
      Grocery::Customer.all.first.address.must_equal "71596 Eden Route Connellymouth LA 98872-9105"
    end

    # MAKE THIS MORE DYNAMIC
    it "The ID, email address is correct for the last customer in the CSV file" do
      Grocery::Customer.all.last.id.must_equal 35
      Grocery::Customer.all.last.email.must_equal "rogers_koelpin@oconnell.org"
      Grocery::Customer.all.last.address.must_equal "7513 Kaylee Summit Uptonhaven DE 64529-2614"
    end
  end #describe

  describe "Customer.find" do
    it "Can find the first customer from the CSV" do
      Grocery::Customer.find(1).must_be_instance_of Grocery::Customer
    end

    it "Can find the last customer from the CSV" do
      Grocery::Customer.find(35).must_be_instance_of Grocery::Customer
    end

    it "Raises an error for a customer that doesn't exist" do
      proc {Grocery::Customer.find(150)}.must_raise ArgumentError
    end
  end
end
