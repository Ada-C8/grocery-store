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
      person = Grocery::Customer.new(customer_id, email, address)
      person.must_be_instance_of Grocery::Customer
    end

    it "Takes an ID, email and address info" do
      # TODO: Your test code here!
      customer_id = 13
      email = "bert@yahoo.com"
      address = "12 Caldwell Ln, Nashvegas, TN 43254"
      person = Grocery::Customer.new(customer_id, email, address)

      person.must_respond_to :customer_id
      person.customer_id.must_equal customer_id

      person.must_respond_to :email
      person.email.must_equal email

      person.must_respond_to :address
      person.address.must_equal address
    end
  end

  describe "Customer.all" do
    it "Returns an array of all customers" do
      all_customers = Grocery::Customer.all
      all_customers.must_be_kind_of Array
    end

    it "Everything in the Array is a Customer" do
      all_customers = Grocery::Customer.all
      all_customers.each do |single_customer|
        single_customer.must_be_instance_of Grocery::Customer
      end
    end

    it "Id's of first and last customers match csv" do
      all_customers = Grocery::Customer.all
      csv = CSV.read("support/customers.csv", 'r')
      csv_id_first = csv[0][0]
      all_customers[0].customer_id.must_equal csv_id_first


      csv = CSV.read("support/customers.csv", 'r')
      csv_id_last = csv[-1][0]
      all_customers[-1].customer_id.must_equal csv_id_last

    end

    it "The email of first and last customers must match csv" do
      all_customers = Grocery::Customer.all
      csv = CSV.read("support/customers.csv", 'r')
      csv_email_first = csv[0][1]
      all_customers[0].email.must_equal csv_email_first

      csv = CSV.read("support/customers.csv", 'r')
      csv_email_last = csv[-1][1]
      all_customers[-1].email.must_equal csv_email_last
    end
    it "The address of first and last customers must match csv" do
      all_customers = Grocery::Customer.all
      csv = CSV.read("support/customers.csv", 'r')
      csv_address_first = csv[0][2..5]
      all_customers[0].address.must_equal csv_address_first

      csv = CSV.read("support/customers.csv", 'r')
      csv_address_last = csv[-1][2..5]
      all_customers[-1].address.must_equal csv_address_last
    end

    it "The number of orders is correct" do
      all_customers = Grocery::Customer.all
      csv = CSV.read("support/customers.csv", 'r')
      all_customers.length.must_equal csv.length
    end
  end

  describe "Customer.find" do
    it "Can find any customer from the CSV" do
      35.times do |x|
        first_customer = Grocery::Customer.find(x+1)
        csv = CSV.read("support/customers.csv", 'r')
        csv_id_first = csv[x][0]
        first_customer.customer_id.must_equal csv_id_first

        csv = CSV.read("support/customers.csv", 'r')
        csv_email_first = csv[x][1]
        first_customer.email.must_equal csv_email_first

        csv = CSV.read("support/customers.csv", 'r')
        csv_address_first = csv[x][2..5]
        first_customer.address.must_equal csv_address_first
      end
    end

    it "Raises an error for a customer that doesn't exist" do
      proc {Grocery::Customer.find(1000)}.must_raise ArgumentError

    end
  end
end
