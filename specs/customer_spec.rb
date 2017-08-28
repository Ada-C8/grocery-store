require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'

require_relative '../lib/customer'

describe "Customer" do
  describe "#initialize" do
    it "Takes an ID, email and address info" do
      id = 666
      email = "sugarcreek@puppers.com"
      address = "1313 4 Paws Lane"
      customer = Grocery::Customer.new(id, email, address)

      customer.must_respond_to :id
      customer.id.must_equal id
      customer.id.must_be_kind_of Integer

      customer.must_respond_to :email
      customer.email.must_equal email

      customer.must_respond_to :address
      customer.address.must_equal address
    end
  end

  describe "Customer.all" do
    it "Returns an Array when Customer.all is called" do
      Grocery::Customer.all.must_be_kind_of Array
    end

    it "Verifies the number of customers is correct" do
      total_customers = CSV.read("support/customers.csv", 'r').length
      Grocery::Customer.all.length.must_equal total_customers
    end

    it "Verifies everything in the Array is a Customer" do
      Grocery::Customer.all.each do |customer|
        customer.must_be_kind_of Grocery::Customer
      end
    end

    it "Matches the ID, email, and address of the first and last customers with what's in the CSV file" do
      Grocery::Customer.all.first.id.must_equal 1
      Grocery::Customer.all.first.email.must_equal "leonard.rogahn@hagenes.org"
      Grocery::Customer.all.first.address.must_equal "71596 Eden Route Connellymouth, LA 98872-9105"

      Grocery::Customer.all.last.id.must_equal 35
      Grocery::Customer.all.last.email.must_equal "rogers_koelpin@oconnell.org"
      Grocery::Customer.all.last.address.must_equal "7513 Kaylee Summit Uptonhaven, DE 64529-2614"

    end


    describe "Customer.find" do
      it "Can find the first customer from the CSV" do
        Grocery::Customer.find(1).id.must_equal 1
        Grocery::Customer.find(1).email.must_equal "leonard.rogahn@hagenes.org"
        Grocery::Customer.find(1).address.must_equal "71596 Eden Route Connellymouth, LA 98872-9105"
      end

      it "Can find the last customer from the CSV" do
        Grocery::Customer.find(35).id.must_equal 35
        Grocery::Customer.find(35).email.must_equal "rogers_koelpin@oconnell.org"
        Grocery::Customer.find(35).address.must_equal "7513 Kaylee Summit Uptonhaven, DE 64529-2614"
      end

      it "Raises an error for a customer that doesn't exist" do
        proc{Grocery::Customer.find(666)}.must_raise ArgumentError
      end
    end
  end
end
