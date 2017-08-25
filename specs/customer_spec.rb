require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'

require_relative '../lib/customer'

describe "Customer" do
  before do
    @csv_data = CSV.read('support/customers.csv')
  end

  describe "#initialize" do
    it "Takes an ID, email and address info" do
      id = 1
      email = "bobbi@bobcat.org"
      address = "5 Alleycat Way S, Seattle WA 98144"
      Customer.new(id, email, address).must_be_kind_of Customer
    end
  end

  describe "Customer.all" do
    it "Returns an array of all customers" do
      Customer.all.must_be_kind_of Array

      5.times do
        Customer.all[rand(0..(Customer.all.length - 1))].must_be_kind_of Customer
      end

      Customer.all.length.must_equal @csv_data.length
    end

    it "Returns the ID, email and address of a Customer as from .csv data set" do

      #Testing for first CSV customer
      Customer.all[0].id.must_equal @csv_data[0][0]

      Customer.all[0].email.must_equal @csv_data[0][1]

      Customer.all[0].address.must_equal @csv_data[0][2..-1]


      #Testing for last CSV customer
      Customer.all[-1].id.must_equal @csv_data[-1][0]

      Customer.all[-1].email.must_equal @csv_data[-1][1]

      Customer.all[-1].address.must_equal @csv_data[-1][2..-1]

      # Useful checks might include:
      #   X Customer.all returns an array
      #   X Everything in the array is a Customer
      #   X The number of orders is correct
      #   X The ID, email address of the first and last
      #       customer match what's in the CSV file
      # Feel free to split this into multiple tests if needed
    end
  end

  describe "Customer.find" do
    before do
      Customer.all
    end

    it "Can find the first customer from the CSV" do
      Customer.find(0).must_be_kind_of Customer

      Customer.find(0).id.must_equal @csv_data[0][0]
    end
  end

  it "Can find the last customer from the CSV" do
    Customer.find(Customer.all.length-1).must_be_kind_of Customer

    Customer.find(Customer.all.length-1).id.must_equal @csv_data[-1][0]  end

    it "Raises an error for a customer that doesn't exist" do
      proc {Customer.find(Customer.all.length)}.must_raise ArgumentError
    end
  end
