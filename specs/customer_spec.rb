require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/customer'


# TODO: uncomment the next line once you start wave 3
# require_relative '../lib/customer'

describe "Customer" do
  describe "#initialize" do
    it "Takes an ID, email and address info" do
      # TODO: Your test code here!
      proc{Grocery::Customer.new("23", "joe.schmoe@joeschmoepizza.com",
        "123 Happy St", "Rainbowville", "VA", "11223")}.must_be_silent
      end
    end



    describe "Customer.all" do
      it "Returns an array of all customers" do
        # TODO: Your test code here!
        # Useful checks might include:
        #   - Customer.all returns an array
        (Grocery::Customer.all).must_be_kind_of Array
      end
      #   - Everything in the array is a Customer
      it "must have Customer class for reach element in the array" do
        (Grocery::Customer.all).each do |customer|
          customer.must_be_instance_of Grocery::Customer
        end
      end

      #   - The number of customerss is correct
      it " has the correct number of customers" do
        ((Grocery::Customer.all).length).must_equal (CSV.open("support/customers.csv", 'r')).count
      end
      #   - The ID, email address of the first and last
      #       customer match what's in the CSV file

      it "matches information from the first customer" do
        customer_csv = (CSV.open("support/customers.csv", 'r').first)
        customer = (Grocery::Customer.all)[0]
        (customer.customer_id).must_equal customer_csv[0].to_i
        (customer.email).must_equal customer_csv[1]
        (customer.address).must_equal customer_csv[2]
      end

      it "matches information from the last customer" do
        customer_csv = (CSV.open("support/customers.csv", 'r').reverse_each.first)
        customer = (Grocery::Customer.all)[-1]
        (customer.customer_id).must_equal customer_csv[0].to_i
        (customer.email).must_equal customer_csv[1]
        (customer.address).must_equal customer_csv[2]
      end
    end

    describe "Customer.find" do
      it "Can find the first customer from the CSV" do
        # TODO: Your test code here!
        Grocery::Customer.find(1) must_equal Grocery::Customer.all[0]
      end

      it "Can find the last customer from the CSV" do
        # TODO: Your test code here!
        Grocery::Customer.find(35) must_equal Grocery::Customer.all[-1]
      end

      it "Raises an error for a customer that doesn't exist" do
        # TODO: Your test code here!
        # TODO: Your test code here!
        proc{Grocery::Customer.find("abc")}.must_raise ArgumentError
      end
    end
  end
