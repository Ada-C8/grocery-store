require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/customer'

describe "Customer" do
  describe "#initialize" do
    it "takes an ID, email address and delivery address" do
      id = 23
      email_address = "summer@casper.io"
      delivery_address = "943 Rasheed Walks,Port Kara,AK,79531"

      customer = Grocery::Customer.new(id, email_address, delivery_address)

      customer.must_respond_to :id # testing method
      customer.id.must_equal id     #must equal a value
      customer.id.must_be_kind_of Integer #check the object class

      customer.must_respond_to :email_address
      customer.email_address.must_equal email_address
      customer.email_address.must_be_kind_of String

      customer.must_respond_to :delivery_address
      customer.delivery_address.must_equal delivery_address
      customer.delivery_address.must_be_kind_of String
    end
  end

  describe "Customer.all" do
    it "Returns an array of all customers" do
      customers = Grocery::Customer.all
      customers.must_be_kind_of Array
    end

    it "checks the number of customer orders is correct" do
      customer_orders = Grocery::Customer.all
      customer_orders.length.must_equal 35
    end

    it "checks the ID of the first customer matches what's in the CSV file" do
      customers = Grocery::Customer.all
      csv = CSV.read("./support/customers.csv")
      csv_id = csv.to_a[0][0].to_i
      csv_id.must_equal customers[0].id
    end

    it "checks ID of the last customer matches what's in the CSV file" do
      customers = Grocery::Customer.all
      csv = CSV.read("./support/customers.csv")
      csv_id = csv.to_a[-1][0].to_i
      csv_id.must_equal customers[-1].id
    end

    it "checks email address of the first customer matches what's in the CSV file" do
      customers = Grocery::Customer.all
      customer_email = customers[0].email_address
      csv = CSV.read("./support/customers.csv")
      csv_email = csv.to_a[0][1]
      csv_email.must_equal customer_email
    end

    it "checks email address of the last customer matches what's in the CSV file" do
      customers = Grocery::Customer.all
      customer_email = customers[-1].email_address
      csv = CSV.read("./support/customers.csv")
      csv_email = csv.to_a[-1][1]
      csv_email.must_equal customer_email
    end

    it "checks delivery_address of the first customer matches what's in the CSV file" do
      customers = Grocery::Customer.all
      csv = CSV.read("./support/customers.csv")
      csv_cust = csv.to_a[0]
      csv_delivery_address = csv_cust[2] + ", " + csv_cust[3] + ", " + csv_cust[4] + " " + csv_cust[5]
      customer_delivery_address = customers[0].delivery_address
      customer_delivery_address.must_equal csv_delivery_address
    end

    it "checks delivery_address of the first customer matches what's in the CSV file" do
      customers = Grocery::Customer.all
      csv = CSV.read("./support/customers.csv")
      csv_cust = csv.to_a[-1]
      csv_delivery_address = csv_cust[2] + ", " + csv_cust[3] + ", " + csv_cust[4] + " " + csv_cust[5]
      customer_delivery_address = customers[-1].delivery_address
      customer_delivery_address.must_equal csv_delivery_address
    end

    it "checks everything in the array is a customer" do
      customers = Grocery::Customer.all
      customers.each do |customer|
        customer.must_be_instance_of Grocery::Customer
      end
    end
  end

  describe "Customer.find" do
    it "Can find the first customer from the CSV" do
      customer = Grocery::Customer.find(1)
      csv = CSV.read("./support/customers.csv")
      csv_id = csv.to_a[0][0]
      customer.id.must_equal csv_id.to_i
    end

    it "Can find the last customer from the CSV" do
      customer = Grocery::Customer.find(35)
      csv = CSV.read("./support/customers.csv")
      csv_id = csv.to_a[-1][0]
      customer.id.must_equal csv_id.to_i
    end

    it "Raises an error for a customer that doesn't exist" do
      proc {Grocery::Customer.find(36)}.must_raise ArgumentError
    end
  end
end
