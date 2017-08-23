require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/customer'

describe "Customer" do
  describe "#initialize" do
    it "Takes an ID, email and address info" do
      proc {Customer.new}.must_raise ArgumentError
      Customer.new(12, "test@test.com", "701 Fake Street, Seattle, WA 98102").class.must_equal Customer
    end
  end

  describe "Customer.all" do
    before do
      Customer.read(File.expand_path('../..', __FILE__) + "/support/customers.csv")
    end
    it "Returns an array of all customers" do
      Customer.all.class.must_equal Array
      Customer.all.each do |customer|
        customer.class.must_equal Customer
      end
      Customer.all.length.must_equal 35
    end
    it "Returns accurate information about the first customer" do
      Customer.all[0].id.must_equal 1
      Customer.all[0].email.must_equal "leonard.rogahn@hagenes.org"
      Customer.all[0].address.must_equal "71596 Eden Route,Connellymouth,LA,98872-9105"
    end
    it "Returns accurate information about the last customer" do
      Customer.all[-1].id.must_equal 35
      Customer.all[-1].email.must_equal "rogers_koelpin@oconnell.org"
      Customer.all[-1].address.must_equal "7513 Kaylee Summit,Uptonhaven,DE,64529-2614"
    end
  end

  describe "Customer.find" do
    before do
      Customer.read(File.expand_path('../..', __FILE__) + "/support/customers.csv")
      #Customer.read("./support/customers.csv")
    end
    it "Can find the first customer from the CSV" do
      Customer.find(1).email.must_equal "leonard.rogahn@hagenes.org"
    end

    it "Can find the last customer from the CSV" do
      Customer.find(35).email.must_equal "rogers_koelpin@oconnell.org"
    end

    it "Raises an error for a customer that doesn't exist" do
      proc {Customer.find(500)}.must_raise ArgumentError
    end
  end
end
