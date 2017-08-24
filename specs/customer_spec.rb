require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'

# TODO: uncomment the next line once you start wave 3
# require_relative '../lib/customer'

describe "Customer" do
  describe "#initialize" do
    it "Takes an ID, email and address info" do
      # TODO: Your test code here!
      id = 13243
      email = "test@test.com"
      address = "1234 McAddressface St."
      customer = Grocery::Customer.new(id, email, address)

      customer.must_be_instance_of Grocery::Customer
      customer.id.must_be_instance_of Integer
      customer.email.must_be_instance_of String
      customer.address.must_be_instance_of String
    end
  end

  describe "Customer.all" do
    it "Returns an array of all customers" do
      # TODO: Your test code here!
      # Useful checks might include:
      #   - Customer.all returns an array
      Grocery::Customer.all.must_be_instance_of Array
      #   - Everything in the array is a Customer
      Grocery::Customer.all[0].must_be_instance_of Array
      #   - The number of orders is correct
      Grocery::Customer.all.length.must_equal 35
      #   - The ID, email address of the first and last
      #       customer match what's in the CSV file
      first_customer = CSV.read("support/orders.csv")[0]
      Grocery::Customer.all[0].id.must_equal first_customer[0].to_i
      Grocery::Customer.all[0].email.must_equal first_customer[1]
      Grocery::Customer.all[0].address.must_equal first_customer[2..5].join(", ")

      # Feel free to split this into multiple tests if needed
    end
  end

  describe "Customer.find" do
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
