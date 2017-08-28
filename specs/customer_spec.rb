require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'

# TODO: uncomment the next line once you start wave 3
require_relative '../lib/customer'

describe "Customer" do
  describe "#initialize" do
    it "Takes an ID, email and address info" do

      joe = Grocery::Customer.new(36,"joe@joeshmoe.com","101 this is hard street, Seattle, Washington, 123456")

      joe.must_be_instance_of Grocery::Customer

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
      Grocery::Customer.all.length.must_equal 35

    end
  end


  describe "Customer.find" do
    it "Can find the first customer from the CSV" do
      # TODO: Your test code here!
      Grocery::Customer.all
      Grocery::Customer.find(1).id.must_equal 1
      Grocery::Customer.find(1).email.must_equal "leonard.rogahn@hagenes.org"
      Grocery::Customer.find(1).delivery_address.must_equal "71596 Eden Route,Connellymouth,LA,98872-9105"

    end


    it "Can find the last customer from the CSV" do
      # TODO: Your test code here!
      Grocery::Customer.all
      Grocery::Customer.find(35).id.must_equal 35
      Grocery::Customer.find(35).email.must_equal "rogers_koelpin@oconnell.org"
      Grocery::Customer.find(35).delivery_address.must_equal "7513 Kaylee Summit,Uptonhaven,DE,64529-2614"
    end


    it "Raises an error for a customer that doesn't exist" do
      # TODO: Your test code here!

      Grocery::Customer.all
      proc {Grocery::Customer.find(100)}.must_raise ArgumentError
      proc {Grocery::Customer.find(73)}.must_raise ArgumentError
      proc {Grocery::Customer.find(36)}.must_raise ArgumentError

    end
  end
end
