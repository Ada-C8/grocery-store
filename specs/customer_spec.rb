require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
# TO-DO: uncomment the next line once you start wave 3
require_relative '../lib/customer'

describe "Customer" do
  describe "#initialize" do
    it "Takes an ID, email and address info" do
      customer_id = 2
      email = "ruben_nikolaus@kreiger.com"
      delivery_address = "876 Kemmer Cove,East Luellatown,AL,21362"

      customers = Grocery::Customer.new(customer_id, email, delivery_address)

      customers.must_respond_to :customer_id #referring to the attr readers in customer.rb
      customers.customer_id.must_equal(customer_id)
      customers.customer_id.must_be_kind_of Integer

      customers.must_respond_to :email
      customers.email.must_equal(email)
      customers.email.must_be_kind_of String

      customers.must_respond_to :delivery_address
      customers.delivery_address.must_equal(delivery_address)
      customers.delivery_address.must_be_kind_of String
    end
  end
end

describe "Customer.all" do
  # Your test code here!
  # Useful checks might include:
  #   - Customer.all returns an array
  #   - Everything in the array is a Customer
  #   - The number of orders is correct
  #   - The ID, email address of the first and last
  #       customer match what's in the CSV file
  # Feel free to split this into multiple tests if needed
  before do
    @customers = Grocery::Customer.all
  end

  it "Returns an array of all customers" do
    @customers.must_be_instance_of Array
  end

  it "Everything in the returned array is a Customer" do

    all_records_are_customers = true

    @customers.each do |customer|
      if customer.class != Grocery::Customer
        all_records_are_customers = false
      end
    end
    all_records_are_customers.must_equal true
  end

  it "Returns the correct number of customers" do
    @customers.length.must_equal 35
  end

  it "Confirms the first customer id & email matches CSV file info" do

    first_customer_id = 1
    first_customer_email = "leonard.rogahn@hagenes.org"

    @customers[0].customer_id.must_equal(first_customer_id) && @customers[0].email.must_equal(first_customer_email)
  end

  it "Confirms the last customer id & email matches CSV file info" do

    last_customer_id = 35
    last_customer_email = "rogers_koelpin@oconnell.org"

    @customers[34].customer_id.must_equal(last_customer_id) && @customers[34].email.must_equal(last_customer_email)
  end

end

describe "Customer.find" do
  it "Can find the first customer from the CSV" do
    first_customer_id = 1
    Grocery::Customer.find(1).customer_id.must_equal(first_customer_id)
  end

  it "Can find the last customer from the CSV" do
    last_customer_id = 35
    Grocery::Customer.find(35).customer_id.must_equal(last_customer_id)
  end

  it "Raises an error for a customer that doesn't exist" do
    #nonexistent_customer_id = 36
    proc { Grocery::Customer.find(36) }.must_raise ArgumentError
  end

end
