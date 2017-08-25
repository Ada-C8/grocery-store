require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/customer'
# TODO: uncomment the next line once you start wave 3


describe "Customer" do
  describe "#initialize" do
    it "Can be created" do
      customer_id = 13
      email = "bert@yahoo.com"
      address = "12 Caldwell Ln, Nashvegas, TN 43254"
      person = Customer.new(customer_id, email, address)
      person.must_be_instance_of Customer
    end

    it "Takes an ID, email and address info" do
      # TODO: Your test code here!
      customer_id = 13
      email = "bert@yahoo.com"
      address = "12 Caldwell Ln, Nashvegas, TN 43254"
      person = Customer.new(customer_id, email, address)

      person.must_respond_to :customer_id
      person.customer_id.must_equal customer_id

      person.must_respond_to :email
      person.email.must_equal email

      person.must_respond_to :address
      person.address.must_equal address
    end
  end

  describe "Customer.all" do
    # TODO: Your test code here!
    # Useful checks might include:
    #   - Customer.all returns an array
    it "Returns an array of all customers" do
      all_customers = Customer.all
      all_customers.must_be_kind_of Array
    end

    it "Everything in the Array is a Customer" do
      all_customers = Customer.all
      all_customers.each do |single_customer|
        single_customer.must_be_instance_of Customer
      end
    end


    #   - Everything in the array is a Customer
    #   - The number of orders is correct
    #   - The ID, email address of the first and last
    #       customer match what's in the CSV file
    # Feel free to split this into multiple tests if needed

  end

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















# require 'minitest/autorun'
# require 'minitest/reporters'
# require 'minitest/skip_dsl'
# require_relative '../lib/customer'
#
# # TODO: uncomment the next line once you start wave 3
#
#
# describe "Customer" do
#   describe "#initialize" do
#     it "Can be created" do
#       customer_id = 13
#       email = "bert@yahoo.com"
#       address = "12 Caldwell Ln, Nashvegas, TN 43254"
#       person = Customer.new(customer_id, email, address)
#       person.must_be_instance_of Customer
#     end
#   end
#   # it "Takes an ID, email and address info" do
#   #   customer_id = 13
#   #   email = "bert@yahoo.com"
#   #   address = "12 Caldwell Ln, Nashvegas, TN 43254"
#   #   person = Customer.new(customer_id, email, address)
#
#   # person.must_respond_to :customer_id
#   # person.customer_id.must_equal customer_id
#   # person.customer_id.must_equal customer_id
#   #
#   # person.must_respond_to :email
#   # person.email.must_equal email
#   #
#   # person.must_respond_to :address
#   # person.address.must_equal address
#   #
#   #
#   #
#   #   xdescribe "Customer.all" do
#   #     xit "Returns an array" do
#   #       # TODO: Your test code here!
#   #       all_customers = Customer.all
#   #       all_customers.must_be_kind_of Array
#   #     end
#   #
#   #     xit "Everything in the array is a Customer"
#   #     all_customers = Customer.all
#   #     all_customers.each do |customers|
#   #       customers.must_be_kind_of Customer
#   #     end
#   #
#   #
#   #
#   #
#   #
#   #     # Useful checks might include:
#   #     #   - Customer.all returns an array
#   #     #   - Everything in the array is a Customer
#   #     #   - The number of customers is correct
#   #     #   - The ID, email address of the first and last
#   #     #       customer match what's in the CSV file
#   #     # Feel free to split this into multiple tests if needed
#   #   end
#   #
#   #
#   #   xdescribe "Customer.find" do
#   #     xit "Can find the first customer from the CSV" do
#   #       # TODO: Your test code here!
#   #     end
#   #
#   #     xit "Can find the last customer from the CSV" do
#   #       # TODO: Your test code here!
#   #     end
#   #
#   #     xit "Raises an error for a customer that doesn't exist" do
#   #       # TODO: Your test code here!
#   #     end
#   #   end
#   # end
