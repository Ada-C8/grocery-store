require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'

require_relative '../lib/customer'

describe "Customer" do
  describe "#initialize" do
    it "Takes an ID, email and address info" do
      id = 1
      email = "leonard.rogahn@hagenes.org"
      address = "71596 Eden Route Seattle, WA 98104"
      customer = Grocery::Customer.new(id, email, address)
      customer.must_respond_to :id
      customer.must_respond_to :email
      customer.must_respond_to :address
    end
  end

  describe "Customer.all" do
    it "Returns an array of all customers" do
      Grocery::Customer.all.must_be_kind_of Array
    end
    it "Everything in the array is a Customer" do
      10.times do
        Grocery::Customer.all[rand(35)].must_be_instance_of Grocery::Customer
      end
    end
    it "The number of customers is correct" do
      Grocery::Customer.all.length.must_equal 35
    end
    it "The ID and products of the first and last" do
      cust = []
      CSV.open("./support/customers.csv").each do |info|
        cust << Grocery::Customer.new(info[0].to_i, info[1], info[2..5].join(", "))
      end 
      cust[0].address.must_equal "71596 Eden Route, Connellymouth, LA, 98872-9105"
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
      proc {Grocery::Customer.find(36)}.must_raise ArgumentError
    end
  end
end 
