require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'

# TODO: uncomment the next line once you start wave 3
require_relative '../lib/customers'

describe "Customer" do
  describe "#initialize" do
    it "Takes an ID, email and address info" do
      # TODO: Your test code here!
      customer = Grocery::Customer.new(4, "email@email.com", "full address")

      customer.id.must_equal 4
      customer.email.must_equal "email@email.com"
      customer.address.must_equal "full address"

      customer.must_respond_to :id
      customer.id.must_be_kind_of Integer
      customer.must_respond_to :email
      customer.must_respond_to :address
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
      Grocery::Customer.all.must_be_instance_of Array
      Grocery::Customer.all[1].must_be_instance_of Grocery::Customer
      Grocery::Customer.all.length.must_equal 35

      Grocery::Customer.all[0].id.must_equal 1
      Grocery::Customer.all[0].email.must_equal "leonard.rogahn@hagenes.org"
      Grocery::Customer.all[34].id.must_equal 35
      Grocery::Customer.all[34].address.must_equal "7513 Kaylee Summit, Uptonhaven, DE, 64529-2614"
    end
  end

  describe "Customer.find" do
    it "Can find the first customer from the CSV" do
      # TODO: Your test code here!
      Grocery::Customer.find(1).id.must_equal 1
      Grocery::Customer.find(1).email.must_equal "leonard.rogahn@hagenes.org"

    end

    it "Can find the last customer from the CSV" do
      # TODO: Your test code here!
      Grocery::Customer.find(35).id.must_equal 35
      Grocery::Customer.find(8).address.must_equal "93968 Elissa Greens, East Garnet, WY, 96410-6413"
    end

    it "Raises an error for a customer that doesn't exist" do
      # TODO: Your test code here!
      proc {Grocery::Customer.find(0)}.must_raise ArgumentError
      proc {Grocery::Customer.find(36)}.must_raise ArgumentError
    end
  end
end
