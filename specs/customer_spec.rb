require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'

require_relative '../lib/customer'

describe "Customer" do
  describe "#initialize" do
    it "Takes an ID, email and address info" do
      id = 5
      email = "testemail.com"
      address = "Drury Lane"

      customer = Grocery::Customer.new(id,email,address)

      customer.must_respond_to :id
      customer.id.must_equal id
      customer.id.must_be_kind_of Integer

      customer.must_respond_to :email
      customer.email.must_be_kind_of String
      customer.email.must_equal email

      customer.must_respond_to :address
      customer.address.must_be_kind_of String
      customer.address.must_equal address
    end
  end

  describe "Customer.all" do
    it "Returns an array of all customers" do
      Grocery::Customer.all.must_be_instance_of Array

      Grocery::Customer.all.each do |customer|
        customer.must_be_instance_of Grocery::Customer
      end

    end

    it "Can be called" do
      Grocery::Customer.must_respond_to :all
    end

    it "Includes all customers in the csv file" do
       Grocery::Customer.all.count.must_equal CSV.read("support/customers.csv", "r").count
    end

    it "Creates a customer object with ID and email address that matches the information of the first customer in the csv" do
       first_customer = Grocery::Customer.all[0]
       csv_first_customer = CSV.read("support/customers.csv", "r")[0]

       first_customer.id.must_equal csv_first_customer[0].to_i
       first_customer.email.must_equal csv_first_customer[1]
    end

    it "Creates a customer object with ID and email address that matches the information of the last customer in the csv" do
       last_customer = Grocery::Customer.all[-1]
       csv_last_customer = CSV.read("support/customers.csv", "r")[-1]

       last_customer.id.must_equal csv_last_customer[0].to_i
       last_customer.email.must_equal csv_last_customer[1]
    end

  end

  describe "Customer.find" do
    it "Can find the first customer from the CSV" do
      customer1 = CSV.read("support/customers.csv", "r")[0]

      Grocery::Customer.find(1).must_be_instance_of Grocery::Customer

      Grocery::Customer.find(1).id.must_equal customer1[0].to_i
      Grocery::Customer.find(1).email.must_equal customer1[1]
    end

    it "Can find the last customer from the CSV" do
      lastcustomer = CSV.read("support/customers.csv", "r")[-1]
      Grocery::Customer.find(35).must_be_instance_of Grocery::Customer

      Grocery::Customer.find(35).id.must_equal lastcustomer[0].to_i
      Grocery::Customer.find(35).email.must_equal lastcustomer[1]
    end

    it "Raises an error for a customer that doesn't exist" do
      proc { Grocery::Customer.find(800) }.must_raise ArgumentError
    end
  end
end
