require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/customer'

describe "Customer" do
  describe "#initialize" do
    it "Takes an ID, email and address info" do
      customer = Grocery::Customer.new(45, "skwiens@gmail.com", {address: "4881 S. Lloyd", city: "Spokane", state: "WA", zip_code: 99223})

      customer.must_be_instance_of Grocery::Customer

      customer.id.must_equal 45
      customer.email.must_equal "skwiens@gmail.com"
      customer.delivery_address[:address].must_equal "4881 S. Lloyd"
      customer.delivery_address[:city].must_equal "Spokane"
      customer.delivery_address[:state].must_equal "WA"
      customer.delivery_address[:zip_code].must_equal 99223
    end
  end

  describe "Customer.all" do
    it "Returns an array" do
      Grocery::Customer.all('./support/customers.csv').must_be_instance_of Array
    end

    it "Everything in the array is a Customer" do
      Grocery::Customer.all('./support/customers.csv').each do |customer|
        customer.must_be_instance_of Grocery::Customer
      end
    end

    it "The number of orders is correct" do
      Grocery::Customer.all('./support/customers.csv').length.must_equal 35
    end

    it "The ID, email, and address of the first customer match the CSV file" do
      customers = Grocery::Customer.all('./support/customers.csv')
      customers[0].id.must_equal "1"
      customers[0].email.must_equal "leonard.rogahn@hagenes.org"
      customers[0].delivery_address[:address].must_equal "71596 Eden Route"
      customers[0].delivery_address[:city].must_equal "Connellymouth"
      customers[0].delivery_address[:state].must_equal "LA"
      customers[0].delivery_address[:zip_code].must_equal "98872-9105"
    end

    it "The ID, email, and address of the last customer match the CSV file" do
      customers = Grocery::Customer.all('./support/customers.csv')
      customers[34].id.must_equal "35"
      customers[34].email.must_equal "rogers_koelpin@oconnell.org"
      customers[34].delivery_address[:address].must_equal "7513 Kaylee Summit"
      customers[34].delivery_address[:city].must_equal "Uptonhaven"
      customers[34].delivery_address[:state].must_equal "DE"
      customers[34].delivery_address[:zip_code].must_equal "64529-2614"
    end
      # TODO: Your test code here!
      # Useful checks might include:
      #   + Customer.all returns an array
      #   + Everything in the array is a Customer
      #   + The number of orders is correct
      #   + The ID, email address of the first and last
      #       customer match what's in the CSV file
      # Feel free to split this into multiple tests if needed

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
