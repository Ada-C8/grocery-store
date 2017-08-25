require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'

# TODO: uncomment the next line once you start wave 3
require_relative '../lib/customer'

describe "Customer" do
  describe "#initialize" do
    it "Takes an ID, email and address info" do
      id = 5
      email = "amymcash@gmail.com"
      address = "1405 East John St., Seattle, WA, 98112"
      customer = Customer.new(id, email, address)

      customer.must_respond_to :id
      customer.id.must_equal id
      customer.id.must_be_kind_of Integer

      customer.must_respond_to :email
      customer.must_respond_to :delivery_address

    end #takes ID
  end #describe initialize
end#end tests
#
describe "Customer.all" do
  #   it "Returns an array of all customers" do
  #     # TODO: Your test code here!

  # it "Returns an array of all customers" do
  #   customer = Customer.all
  #   customer.must_be_kind_of Array
  # end #returns array
  #
  # it "Everything in the array is an customer " do
  #   customer = Customer.all
  #   customer.each do |item|
  #      item.must_be_instance_of Customer
  #   end #customer each do
  # end #everything is an customer
  #
  it "The number of orders is correct" do
    customer = Customer.all
    customer.length.must_equal 35
  end # number is correct
  #
  # it "The ID and products of the first and last orders match whats in the CSV file" do
  # end #ID/products match
end #customer all

#     #   - The ID, email address of the first and last
#     #       customer match what's in the CSV file
#
describe "Customer.find" do
  describe "Customer.find" do
    it "Can find the first customer from the CSV" do
      x = Customer.find(1)
      x.delivery_address.include?("Eden").must_equal true
      x.email.include?("leonard.rogahn@hagenes.org").must_equal true
      x.id.must_equal 1
    end #can find the first customer

    it "Can find the last customer from the CSV" do
      x = Customer.find(35)
      x.delivery_address.include?("Kaylee").must_equal true
      x.email.include?("rogers_koelpin@oconnell.org").must_equal true
      x.id.must_equal 35
    end #can find the last customer

    # it "Raises an error for as customer that doesn't exist" do
    #   x = Grocery::Customer.find(110)
    #   x.must_equal false
    # end #raises an error
  end #end Order.find
end
