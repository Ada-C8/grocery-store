require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/customer'
require 'csv'

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
      Grocery::Customer.must_respond_to :all
      Grocery::Customer.all.must_be_instance_of Array
      #   - Everything in the array is a Customer
      Grocery::Customer.all[0].must_be_instance_of Grocery::Customer
      #   - The number of orders is correct
      Grocery::Customer.all.length.must_equal 35

    end

    it "First Customer matches CSV file" do
      #   - The ID, email address of the first and last
      #       customer match what's in the CSV file
      first_customer = CSV.read("support/customers.csv")[0]
      Grocery::Customer.all[0].id.must_equal first_customer[0].to_i
      Grocery::Customer.all[0].email.must_equal first_customer[1]
      Grocery::Customer.all[0].address.must_equal first_customer[2..5].join(", ")
    end

    it "Last Customer matches CSV file" do
      last_customer = CSV.read("support/customers.csv")[34]
      Grocery::Customer.all[34].id.must_equal last_customer[0].to_i
      Grocery::Customer.all[34].email.must_equal last_customer[1]
      Grocery::Customer.all[34].address.must_equal last_customer[2..5].join(", ")
    end
  end

  describe "Customer.find" do
    it "Returns a Customer object with the same ID" do
      Grocery::Customer.must_respond_to(:find)
      randomIndex = rand(1..35)
      Grocery::Customer.find(randomIndex).id.must_equal CSV.read("support/customers.csv")[randomIndex - 1][0].to_i
    end

    it "Can find the first customer from the CSV" do
      # TODO: Your test code here!
      first_customer = CSV.read("support/customers.csv")[0]
      Grocery::Customer.find(1).must_be_instance_of Grocery::Customer
      Grocery::Customer.find(1).id.must_equal first_customer[0].to_i
      # Grocery::Customer.find(1).email.must_equal first_customer[1]
      # Grocery::Customer.find(1).address.must_equal first_customer[2..5].join(", ")
    end

    it "Can find the last customer from the CSV" do
      # TODO: Your test code here!
      last_customer = CSV.read("support/customers.csv")[34]
      Grocery::Customer.find(35).must_be_instance_of Grocery::Customer
      Grocery::Customer.find(35).id.must_equal last_customer[0].to_i
    end

    it "Raises an error for a customer that doesn't exist" do
      # TODO: Your test code here!
      proc { Grocery::Customer.find(101) }.must_raise ArgumentError
    end
  end
end
