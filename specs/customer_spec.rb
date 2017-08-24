require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require 'pry'

# TODO: uncomment the next line once you start wave 3
require_relative '../lib/customer'

describe "Customer" do
  describe "#initialize" do
    it "Takes an ID, email and address info" do
      id = 5
      email = "alice@email.com"
      address = {address1: "123 S 1st Ave", city: "Seattle", state: "WA", zipcode: "12345"}
      comment = "this won't work"
      alice = Grocery::Customer.new(id, email, address)
      alice.must_be_kind_of Grocery::Customer

      alice.id.must_equal id
      alice.email.must_equal email
      alice.address.must_equal address

      # raises ArgumentError
      # mad_hatter = Grocery::Customer.new(id, email, address, comment)

      # TODO: Your test code here!
    end
  end

  describe "Customer.all" do
    before do
      @customers = Grocery::Customer.all
    end
    it "Returns an array" do
      @customers.must_be_kind_of Array
    end

    it "Array is filled with Customers" do
      10.times do
        @customers[rand(35)].must_be_kind_of Grocery::Customer
      end
    end

    it "Has right number of items" do
      @customers.length.must_equal 35
    end

    xit "first and last are same as csv" do
      customers_first = 	[1, {"Slivered Almonds" => 22.88, "Wholewheat flour" => 1.93, "Grape Seed Oil" => 74.9}]

      @customers.first.id.must_equal customers_first[0]
      @customers.first.products.must_equal customers_first[1]

      customers_last = [100, {"Allspice" => 64.74, "Bran" => 14.72, "UnbleachedFlour" => 80.59}]

      @customers.last.id.must_equal customers_last[0]
      @customers.last.products.must_equal customers_last[1]
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
