require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/customer'


describe "Customer" do
  describe "#initialize" do
    it "Takes an ID, email and address info" do
      customer = Grocery::Customer.new(12, "lenertzdiane@gmail.com", "5655", "Seattle", "WA", 98105)

      customer.must_respond_to :id
      customer.id.must_equal 12
      customer.id.must_be_kind_of Integer

      customer.must_respond_to :email
      customer.email.must_equal "lenertzdiane@gmail.com"

      customer.must_respond_to :address
      customer.address.must_equal "5655"

      customer.must_respond_to :city
      customer.city.must_equal "Seattle"

      customer.must_respond_to :zip
      customer.zip.must_equal 98105

    end
  end

  describe "Customer.all" do
    it "Returns an array of all customers" do

      customer = Grocery::Customer.all
      customer.must_be_kind_of Array

      customer.each do |cust|
        cust.must_be_instance_of Grocery::Customer
      end

      Grocery::Customer.line_count.must_equal Grocery::Customer.customers.length

      read_csv = CSV.read("support/customers.csv")
      customers = Grocery::Customer.customers
      id = customers[18].id
      email = customers[18].email

      csv_id = read_csv[18][0]
      csv_email = read_csv[18][1]

      id.must_equal csv_id
      email.must_equal csv_email

    end
  end

  describe "Customer.find" do
    it "Can find the first customer from the CSV" do
      Grocery::Customer.all
      Grocery::Customer.find(1).id.to_i.must_equal 1
    end

    it "Can find the last customer from the CSV" do
      Grocery::Customer.all
      id = Grocery::Customer.find(35).id.to_i
      id.must_equal 35
    end

    it "Raises an error for a customer that doesn't exist" do
      Grocery::Customer.all
      proc{Grocery::Customer.find(100)}.must_raise ArgumentError

    end
  end
end
