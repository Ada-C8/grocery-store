require_relative 'spec_helper'

# TODO: uncomment the next line once you start wave 3
# require_relative '../lib/customer'
describe "Customer" do
  describe "#initialize" do
    it "Takes an ID, email and address info" do
      customer_id = 45
      email = "mail@email.com"
      address = "111 Main St."
      city = "Louisville"
      state = "Kentucky"
      zip = "11223"
      customer = Grocery::Customer.new(customer_id, email, address, city, state, zip)

      customer.must_respond_to :customer_id
      customer.customer_id.must_equal customer_id
      customer.customer_id.must_be_kind_of Integer

      customer.must_respond_to :email
      customer.email.must_equal email
      customer.email.must_be_kind_of String

      customer.must_respond_to :address
      customer.address.must_equal address
      customer.address.must_be_kind_of String

      customer.must_respond_to :city
      customer.city.must_equal city
      customer.city.must_be_kind_of String

      customer.must_respond_to :state
      customer.state.must_equal state
      customer.state.must_be_kind_of String

      customer.must_respond_to :zip
      customer.zip.must_equal zip
      customer.zip.must_be_kind_of String
    end
  end


  describe "Customer.all" do
    it "Returns an array of all customers" do
      Grocery::Customer.all.must_be_kind_of Array
    end

    it "Everything in the array is a Customer" do
      Grocery::Customer.all.each do |customer|
        customer.must_be_kind_of Grocery::Customer
      end
    end

    it "the number of customers is correct" do
      Grocery::Customer.all.length.must_equal 35
    end

    it "the customer_id, email, address of the first and last customer matches the CSV file" do
      Grocery::Customer.all.first.customer_id.must_equal 1
      Grocery::Customer.all.first.email.must_equal "leonard.rogahn@hagenes.org"
      Grocery::Customer.all.first.address.must_equal "71596 Eden Route"
      Grocery::Customer.all.first.city.must_equal "Connellymouth"
      Grocery::Customer.all.first.state.must_equal "LA"
      Grocery::Customer.all.first.zip.must_equal "98872-9105"

      Grocery::Customer.all.last.customer_id.must_equal 35
      Grocery::Customer.all.last.email.must_equal "rogers_koelpin@oconnell.org"
      Grocery::Customer.all.last.address.must_equal "7513 Kaylee Summit"
      Grocery::Customer.all.last.city.must_equal "Uptonhaven"
      Grocery::Customer.all.last.state.must_equal "DE"
      Grocery::Customer.all.last.zip.must_equal "64529-2614"
    end
  end

  describe "Customer.find" do
    it "Can find the first customer from the CSV" do
      customer = Grocery::Customer.find(1)

      customer.must_be_instance_of Grocery::Customer
      customer.customer_id.must_equal 1
      customer.email.must_equal "leonard.rogahn@hagenes.org"
      customer.address.must_equal "71596 Eden Route"
      customer.city.must_equal "Connellymouth"
      customer.state.must_equal "LA"
      customer.zip.must_equal "98872-9105"
    end

    it "Can find the last customer from the CSV" do
      customer = Grocery::Customer.find(35)

      customer.must_be_instance_of Grocery::Customer
      customer.customer_id.must_equal 35
      customer.email.must_equal "rogers_koelpin@oconnell.org"
      customer.address.must_equal "7513 Kaylee Summit"
      customer.city.must_equal "Uptonhaven"
      customer.state.must_equal "DE"
      customer.zip.must_equal "64529-2614"
    end

    it "Raises an error for a customer that doesn't exist" do
      proc {
        Grocery::Customer.find(50)
      }.must_raise ArgumentError
    end
  end
end 
