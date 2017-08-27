require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'

require_relative '../lib/customer'

describe "Customer" do
  describe "#initialize" do
    it "Takes an ID, email and address info" do
      id = 45
      email = "bb@gmail.com"
      delivery_address = "248 hello world seattle"
      customer = Grocery::Customer.new(id, email, delivery_address)

      customer.must_respond_to :id
      customer.id.must_equal id
      customer.id.must_be_kind_of Integer

      customer.must_respond_to :email
      customer.email.must_equal email
      customer.email.must_be_kind_of String

      customer.must_respond_to :delivery_address
      customer.delivery_address.must_equal delivery_address
      customer.delivery_address.must_be_kind_of String

    end
  end

  describe "Customer.all" do
    it "Returns an array of all customers" do
      customers = Grocery::Customer.all

      #Customer.all returns an array
      customers.must_be_instance_of Array

      customers.each do |line|
        line.must_be_instance_of Grocery::Customer
      end


      #The number of orders is correct
      customers.length.must_equal 35

      customers.first.id.must_equal 1
      customers.last.id.must_equal 35


      #   - The ID, email address of the first and last
      #       customer match what's in the CSV file
      customers.first.email.must_equal "leonard.rogahn@hagenes.org"
      customers.last.email.must_equal "rogers_koelpin@oconnell.org"

      customers.first.delivery_address.must_equal ["71596 Eden Route","Connellymouth","LA","98872-9105"]
      customers.first.delivery_address.must_be_instance_of Array

      customers.last.delivery_address.must_equal ["7513 Kaylee Summit","Uptonhaven","DE","64529-2614"]
      customers.last.delivery_address.must_be_instance_of Array


      #   - Everything in the array is a Customer

    end
  end

  xdescribe "Customer.find" do
    it "Can find the first customer from the CSV" do
      # TODO: Your test code here!
    end

    it "Can find the last customer from the CSV" do
      # TODO: Your test code here!
    end

    it "Raises an error for a customer that doesn't exist" do
      # TODO: Your test code here!
    end
  end
end
