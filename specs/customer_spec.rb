require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require 'csv'
# TODO: uncomment the next line once you start wave 3
 require_relative '../lib/customer'

describe "Customer" do
  before do
    @customer_csv = CSV.read("/Users/averikitsch/ada/week-03/grocery-store/support/customers.csv")
    @customer_array = Grocery::Customer.all(@customer_csv)
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

  describe "Customer.all" do
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
        i.must_be_instance_of Grocery::Customer
      end
      @customer_array.length.must_equal 35
    end

    it "Returns correct info for first and last" do
      @customer_array[0].id.must_equal 1
      @customer_array[0].email.must_equal "leonard.rogahn@hagenes.org"
      address1 = {:address_line=>"71596 Eden Route", :city=>"Connellymouth", :state=>"LA", :zip_code=>"98872-9105"}
      @customer_array[0].address.must_equal address1
      @customer_array[-1].id.must_equal 35
      @customer_array[-1].email.must_equal "rogers_koelpin@oconnell.org"
      address2 = {address_line:"7513 Kaylee Summit",	city:"Uptonhaven",	state:"DE",	zip_code:"64529-2614"}
      @customer_array[-1].address.must_equal address2
    end
  end

  describe "Customer.find" do
    it "Can find the first customer from the CSV" do
      customer1 = Grocery::Customer.find(@customer_csv,1)
      customer1.must_be_instance_of Grocery::Customer
      customer1.id.must_equal 1
    end

    it "Can find the last customer from the CSV" do
      customer1 = Grocery::Customer.find(@customer_csv,35)
      customer1.must_be_instance_of Grocery::Customer
      customer1.id.must_equal 35
    end

    it "Raises an error for a customer that doesn't exist" do
      proc{Grocery::Customer.find(@customer_csv,101)}.must_raise ArgumentError
    end
  end
end
