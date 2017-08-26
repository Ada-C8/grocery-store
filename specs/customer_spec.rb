require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'

# TODO: uncomment the next line once you start wave 3
require_relative '../lib/customer'

# xdescribe "Customer" do
#   describe "#initialize" do
#     it "Takes an ID, email and address info" do
#       # TODO: Your test code here!
#     end
#   end

  # xdescribe "Customer.all" do
  #   it "Returns an array of all customers" do
  #     # TODO: Your test code here!
  #     # Useful checks might include:
  #     #   - Customer.all returns an array
  #     #   - Everything in the array is a Customer
  #     #   - The number of orders is correct
  #     #   - The ID, email address of the first and last
  #     #       customer match what's in the CSV file
  #     # Feel free to split this into multiple tests if needed
  #   end
  # end


  describe "Customer.find" do
    it "Can find the first customer from the CSV" do
      # TODO: Your test code here!
      Grocery::Customer.find(1).id.must_equal 1

    end


    it "Can find the last customer from the CSV" do
      # TODO: Your test code here!
      # Grocery::Customer.all
      Grocery::Customer.find(35).id.must_equal 35
    end


    it "Raises an error for a customer that doesn't exist" do
      # TODO: Your test code here!

      # Grocery::Customer.all
      Grocery::Customer.find(100).id.must_equal 100
      proc {Grocery::Order.find(100)}.must_raise ArgumentError

      # proc { obj1.do_something }.must_raise NoMethodError

    end
  end
# end
