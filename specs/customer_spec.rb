require_relative 'spec_helper'

# TODO: uncomment the next line once you start wave 3
# require_relative '../lib/customer'
describe "Customer" do
  describe "#initialize" do
    it "Takes an ID, email and address info" do
      customer_id = 45
      email = "mail@email.com"
      address = "111 Main St."
      customer = Grocery::Customer.new(customer_id, email, address)

      customer.must_respond_to :customer_id
      customer.customer_id.must_equal customer_id
      customer.customer_id.must_be_kind_of Integer

      customer.must_respond_to :email
      customer.email.must_equal email
      customer.email.must_be_kind_of String

      customer.must_respond_to :address
      customer.address.must_equal address
      customer.address.must_be_kind_of String
    end #end of it

    end #end of describe 2


  # describe "Customer.all" do
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
  #
  # describe "Customer.find" do
  #   it "Can find the first customer from the CSV" do
  #     # TODO: Your test code here!
  #   end
  #
  #   it "Can find the last customer from the CSV" do
  #     # TODO: Your test code here!
  #   end
  #
  #   it "Raises an error for a customer that doesn't exist" do
  #     # TODO: Your test code here!
  #   end
  # end
end #end of describe all
