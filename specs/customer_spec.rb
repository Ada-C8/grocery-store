require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'

# TODO: uncomment the next line once you start wave 3
require_relative '../lib/customers'

describe "Customer" do
  describe "#initialize" do
    it "Takes an ID, email and address info" do
      # TODO: Your test code here!
      id = 5
      email = "jhkhkjh@gmail.com"
      address = "11134 Acorn loop, Tahoma, WI 92342"
      customer = Customer.new(id, email, address)

      customer.must_respond_to :id
      customer.id.must_equal id
      customer.id.must_be_kind_of Integer

      customer.must_respond_to :email
      customer.email.must_equal email
      customer.email.must_be_instance_of String

      customer.must_respond_to :address
      customer.address.must_equal address
      customer.address.must_be_instance_of String
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
      Customer.all.must_be_instance_of Array
      Customer.all[1].must_be_instance_of Customer
      Customer.all.length.must_equal 35

      Customer.all[0].id.must_equal 1
      Customer.all[0].email.must_equal "leonard.rogahn@hagenes.org"
      Customer.all[34].id.must_equal 35
      Customer.all[34].address.must_equal "7513 Kaylee Summit, Uptonhaven, DE, 64529-2614"
    end
  end

  describe "Customer.find" do
    it "Can find the first customer from the CSV" do
      # TODO: Your test code here!
      Customer.find(1).id.must_equal 1
      Customer.find(1).email.must_equal "leonard.rogahn@hagenes.org"
      Customer.find(1).address.must_equal "71596 Eden Route, Connellymouth, LA, 98872-9105"

    end

    it "Can find the last customer from the CSV" do
      # TODO: Your test code here!
      Customer.find(35).id.must_equal 35
      Customer.find(35).email.must_equal "rogers_koelpin@oconnell.org"
      Customer.find(35).address.must_equal "7513 Kaylee Summit, Uptonhaven, DE, 64529-2614"
    end

    it "Raises an error for a customer that doesn't exist" do
      # TODO: Your test code here!
      Customer.find(0).must_be_instance_of String
      Customer.find(36).must_be_instance_of String
    end
  end
end
