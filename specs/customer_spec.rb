require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'

# TODO: uncomment the next line once you start wave 3
require_relative '../lib/customer'

describe "Customer" do
  describe "#initialize" do
    it "Takes an ID, email and address info" do
      # TODO: Your test code here!
      id = 1337
      email = "cutestcats@kittens.com"
      address = "321 Happy Place"
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
      # TODO: Your test code here!
      all_customers = Grocery::Customer.all
      all_customers.must_be_instance_of Array
      all_customers[0].id.must_equal 1
      all_customers[0].email.must_equal "leonard.rogahn@hagenes.org"
      all_customers[0].address.must_equal "71596 Eden Route Connellymouth LA 98872-9105"
      all_customers[34].id.must_equal 35
      all_customers[34].email.must_equal "rogers_koelpin@oconnell.org"
      all_customers[34].address.must_equal "7513 Kaylee Summit Uptonhaven DE 64529-2614"
      all_customers.each do |customers|
        customers.must_be_instance_of Grocery::Customer
      end
        all_customers.length.must_equal 35


      # Useful checks might include:
      #   - Customer.all returns an array
      #   - Everything in the array is a Customer
      #   - The number of orders is correct
      #   - The ID, email address of the first and last
      #       customer match what's in the CSV file
      # Feel free to split this into multiple tests if needed
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
