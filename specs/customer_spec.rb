require 'csv'

require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'

# uncomment the next line once you start wave 3
require_relative '../lib/customer'

describe "Customer" do
  describe "#initialize" do
    it "Takes an ID, email and address info" do
      id = 1337
      email = "john@johndoe.org"
      address = "1900 E. Blue Street, Seattle, WA 98101"
      customer = Customer.new(id, email, address)

      customer.must_respond_to :id
      customer.id.must_equal id
      customer.id.must_be_kind_of Integer

      customer.must_respond_to :email
      customer.email.must_be_kind_of String
      customer.address.must_be_kind_of String
    end
  end

  describe "Customer.all" do
    it "Returns an array of all customers" do

      Customer.all.must_be_kind_of Array
    end

      #   - Everything in the array is a Customer
    it "Elements in array are all instances of Customer" do
      Customer.all.each do |customer|
          customer.must_be_instance_of Customer
        end
    end

##NOT FINSIHED:
    #   - The number of orders is correct
    it "Number of orders is correct" do
      Customer.all.length.must_equal 35 #CHECK CSV file for this
    end

    #   - The ID, email address of the first and last customer match what's in the CSV file
    it "ID and email address of first customer matches with CSV file" do
      Customer.all[0].id.must_equal 1
      Customer.all[0].email.must_equal "leonard.rogahn@hagenes.org"
    end

    it "ID and email address of last customer matches with CSV file" do
      Customer.all[34].id.must_equal 35
      customer.all[34].email.must_equal "rogers_koelpin@oconnell.org"
    end
  end

  # describe "Customer.find" do  ## Be careful with find - might try using Ruby's find instead of mine!
  #   it "Can find the first customer from the CSV" do
  #     Customer.all.find(1).must_equal Customer.all[0]
  #   end
  #
  #   it "Can find the last customer from the CSV" do
  #     Customer.all.find(35).must_equal Customer.all[34]
  #   end
  #
  #   it "Raises an error for a customer that doesn't exist" do
  #       proc {Customer.all.find(105)}.must_raise ArgumentError
  #     end
  # end
end
