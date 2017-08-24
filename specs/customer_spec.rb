require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/customer'

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new


# TODO: uncomment the next line once you start wave 3
# require_relative '../lib/customer'

describe "Customer" do
  describe "#initialize" do
    it "Takes an ID, email and address info" do
      # TODO: Your test code here!
      id = 3
      email = "email@gmail.com"
      street_address = "Street"
      city = "City"
      state = "State"
      zipcode = "Zipcode"

      test_customer = Grocery::Customer.new(id, email, street_address, city, state, zipcode)
      test_customer.delivery_address.must_equal "Street, City, State, Zipcode"

      def <=>(other)

      end
    end
  end

  describe "Customer.all" do
    # TODO: Your test code here!
    # Useful checks might include:
    #   - Customer.all returns an array
    #   - Everything in the array is a Customer
    #   - The number of orders is correct
    #   - The ID, email address of the first and last
    #       customer match what's in the CSV file
    # Feel free to split this into multiple tests if needed
    it "Returns an array of all customers" do
          Grocery::Customer.all.must_be_kind_of Array
    end #it "Returns an array of all customers" do

    it "will only contain instances of the Customer class in the array" do
      test = Grocery::Customer.all
      test.length.times do |i|
        test[i].must_be_kind_of Grocery::Customer
      end
    end #"will only return instances of the Customer class in the array" do

    it "will have the right number of Customer instances in the array" do
      all_customers = CSV.read("support/customers.csv", 'r')
      Grocery::Customer.all.length.must_equal all_customers.length
    end #it "will have the right number of Customer instances in the array" do

    it "will have the right customer_id for the first customer" do
       
    end #it "will have the right customer_id for the first customer" do


  end #describe "Customer.all" do

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
