require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'

# TODO: uncomment the next line once you start wave 3
require_relative '../lib/customer'

describe "Customer" do
  describe "#initialize" do
    it "Takes an ID, email and address info" do
      customer_id = 5
      email = "amymcash@gmail.com"
      address = "1405 East John St., Seattle, WA, 98112"
      customer = Grocery::Customer.new(customer_id, email, address)

      customer.must_respond_to :customer_id
      customer.customer_id.must_equal customer_id
      customer.customer_id.must_be_kind_of Integer

      customer.must_respond_to :email
      customer.must_respond_to :delivery_address

    end #takes ID
  end #describe initialize
end#end tests
#
describe "Customer.all" do

  it "Returns an array of all customers" do
    customer = Grocery::Customer.all
    customer.must_be_kind_of Array
  end #returns array

  it "Everything in the array is an customer " do
    customer = Grocery::Customer.all
    customer.each do |item|
       item.must_be_instance_of Grocery::Customer
    end #customer each do
  end #everything is an customer

  it "The number of orders is correct" do
    customer = Grocery::Customer.all
    customer.length.must_equal 35
  end # number is correct
  #
#   # it "The ID and products of the first and last orders match whats in the CSV file" do
#   # end #ID/products match
end #customer all

#     #   - The ID, email address of the first and last
#     #       customer match what's in the CSV file

describe "Grocery::Customer.find" do
  describe "Grocery::Customer.find" do
    it "Can find the first customer from the CSV" do
      x = Grocery::Customer.find(1)
      x.delivery_address.include?("Eden").must_equal true
      x.email.include?("leonard.rogahn@hagenes.org").must_equal true
      x.customer_id.must_equal 1
    end #can find the first customer

    it "Can find the last customer from the CSV" do
      x = Grocery::Customer.find(35)
      x.delivery_address.include?("Kaylee").must_equal true
      x.email.include?("rogers_koelpin@oconnell.org").must_equal true
      x.customer_id.must_equal 35
    end #can find the last customer

    it "Raises an error for as customer that doesn't exist" do
      proc {Grocery::Customer.find(110)}.must_raise ArgumentError
    end #raises an errorf
  end #end Order.find
end
