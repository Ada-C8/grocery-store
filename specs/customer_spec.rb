require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/customer'

describe "Customer" do
  describe "#initialize" do
    it "Takes an ID, email and address info" do
      customer = Grocery::Customer.new(1, "email", "address")

      customer.id.must_equal 1
      customer.email.must_equal "email"
      customer.address.must_equal "address"
    end
  end

  describe "Customer.all" do
    it "Returns an array of all customers" do
      Grocery::Customer.all.must_be_instance_of Array
      Grocery::Customer.all.length.must_equal 35
      Grocery::Customer.all.each do |element|
        element.must_be_instance_of Grocery::Customer
      end
      Grocery::Customer.all[0].id.must_equal 1
      Grocery::Customer.all[0].email.must_equal "leonard.rogahn@hagenes.org"
      Grocery::Customer.all[0].address.must_equal "71596 Eden Route, Connellymouth, LA, 98872-9105"
      Grocery::Customer.all[-1].id.must_equal 35
      Grocery::Customer.all[-1].email.must_equal "rogers_koelpin@oconnell.org"
      Grocery::Customer.all[-1].address.must_equal "7513 Kaylee Summit, Uptonhaven, DE, 64529-2614"
    end
  end

  describe "Customer.find" do
    it "Can find the first customer from the CSV" do
      Grocery::Customer.find(1).id.must_equal 1
    end

    it "Can find the last customer from the CSV" do
      Grocery::Customer.find(35).id.must_equal 35
    end

    it "Raises an error for a customer that doesn't exist" do
      proc {Grocery::Customer.find(0)}.must_raise ArgumentError #what's up with this proc syntax?
    end
  end
end
