require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'

require_relative '../lib/customer'

describe "Customer" do
  before do
    customer_array = [1,"leonard.rogahn@hagenes.org","71596 Eden Route","Connellymouth","LA","98872-9105"]
  end

  describe "#initialize" do
    it "Takes an ID, email and address info" do
      id = 1
      email = "bobbi@bobcat.org"
      address = "5 Alleycat Way S, Seattle WA 98144"
      Customer.new(id, email, address).must_be_kind_of Customer
    end
  end

  describe "Customer.all" do
    it "Returns an array of all customers" do
      # TODO: Your test code here!
      # Useful checks might include:
      #   - Customer.all returns an array
      #   - Everything in the array is a Customer
      #   - The number of customers is correct
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
