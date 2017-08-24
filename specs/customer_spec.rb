require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'

# TODO: uncomment the next line once you start wave 3
require_relative '../lib/customer'

# adding for color
reporter_options = { color: true }
Minitest::Reporters.use! Minitest::Reporters::DefaultReporter.new(reporter_options)

describe "Customer" do
  describe "#initialize" do
    before do
      @customer = Grocery::Customer.new(1,"leonard.rogahn@hagenes.org", ["71596 Eden Route", "Connellymouth", "LA", "98872-9105"])
    end
    it "Takes an ID, email and address info" do
      expected_id = 1
      expected_email = "leonard.rogahn@hagenes.org"
      expected_address = ["71596 Eden Route", "Connellymouth", "LA", "98872-9105"]

      @customer.id.must_equal expected_id
      @customer.email.must_equal expected_email
      @customer.delivery_address.must_equal expected_address
    end
  end

  describe "Customer.all" do
    before do
      @all_customers = Grocery::Customer.all
    end
    it "Returns an array of all customers" do
      @all_customers.must_be_instance_of Array

      @all_customers.each do |customer|
        customer.must_be_instance_of Grocery::Customer
      end

      num_customers = 35 # num customers in csv file
      @all_customers.length.must_equal num_customers
    end

    it "ID, email , and address of first customer match csv file" do
      expected_id = 1
      expected_email = "leonard.rogahn@hagenes.org"
      expected_address = ["71596 Eden Route", "Connellymouth", "LA", "98872-9105"]

      @all_customers.first.id.must_equal expected_id
      @all_customers.first.email.must_equal expected_email
      @all_customers.first.delivery_address.must_equal expected_address
    end

    it "ID, email , and address of last customer match csv file" do
      expected_id = 35
      expected_email = "rogers_koelpin@oconnell.org"
      expected_address = ["7513 Kaylee Summit", "Uptonhaven", "DE", "64529-2614"]

      @all_customers.last.id.must_equal expected_id
      @all_customers.last.email.must_equal expected_email
      @all_customers.last.delivery_address.must_equal expected_address
    end
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
