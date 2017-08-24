require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'

# TODO: uncomment the next line once you start wave 3
require_relative '../lib/customer'

describe "Customer" do
  describe "#initialize" do
    it "Takes an ID, email and address info" do
      id = 5
      email = "testemail.com"
      address = "Drury Lane"

      customer = Grocery::Customer.new(id,email,address)

      customer.must_respond_to :id
      customer.id.must_equal id
      customer.id.must_be_kind_of Integer

      customer.must_respond_to :email
      customer.email.must_be_kind_of String
      customer.email.must_equal email

      customer.must_respond_to :address
      customer.address.must_be_kind_of String
      customer.address.must_equal address
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
      Grocery::Customer.all.must_be_kind_of Array

      Grocery::Customer.all.each do |customer|
        customer.must_be_kind_of Grocery::Customer
      end

    end

    it "Can be called" do
      Grocery::Customer.must_respond_to :all
    end

    it "Includes all customers in the csv file" do
       Grocery::Customer.all.count.must_equal CSV.read("support/customers.csv", "r").count
    end


  end

  describe "Customer.find" do
    it "Can find the first customer from the CSV" do
      Grocery::Customer.find(1).must_be_instance_of Grocery::Customer
      customer1_email = CSV.read("support/customers.csv", "r")[0][1]

      Grocery::Customer.find(1).email.must_equal customer1_email
    end

    it "Can find the last customer from the CSV" do
      Grocery::Customer.find(35).must_be_instance_of Grocery::Customer
      lastcustomer_email = CSV.read("support/customers.csv", "r")[-1][1]

      Grocery::Customer.find(35).email.must_equal lastcustomer_email
    end

    it "Raises an error for a customer that doesn't exist" do
      proc { Grocery::Customer.find(800) }.must_raise ArgumentError
    end
  end
end
