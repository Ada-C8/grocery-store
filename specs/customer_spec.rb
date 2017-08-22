require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require 'csv'
# TODO: uncomment the next line once you start wave 3
 require_relative '../lib/customer'

describe "Customer" do
  before do
    customer_csv = CSV.read("/Users/averikitsch/ada/week-03/grocery-store/support/customers.csv")
    @customer_array = Grocery::Customer.all(customer_csv)
  end
  describe "#initialize" do
    it "Takes an ID, email and address info" do
      id = 101
      email = "aekitsch@gmail.com"
      address = {
        address_line: "3932 S 284th Pl",
        city: "Auburn",
        state: "WA",
        zip_code: "98001"
      }
      customer = Grocery::Customer.new(id,email,address)

      customer.must_respond_to :id
      customer.id.must_equal id
      customer.id.must_be_kind_of Integer

      customer.must_respond_to :email
      customer.email.must_equal email

      customer.must_respond_to :address
      customer.address.must_be_kind_of Hash
    end
  end

  xdescribe "Customer.all" do
    it "Returns an array of all customers" do
      # TODO: Your test code here!
      # Useful checks might include:
      #   - Customer.all returns an array
      #   - Everything in the array is a Customer
      #   - The number of orders is correct
      #   - The ID, email address of the first and last
      #       customer match what's in the CSV file
      # Feel free to split this into multiple tests if needed
      @customer_array.must_be_kind_of Array
      @customer_array.each do |i|
        i.class.must_be_instance_of Grocery::Customer
      end
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
