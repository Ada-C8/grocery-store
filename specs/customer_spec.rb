require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require 'pry'

# TODO: uncomment the next line once you start wave 3
require_relative '../lib/customer'

describe "Customer" do
  before do
    @customers = Grocery::Customer.all
  end
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

    it "first and last are same as csv" do
      customers_first = [1, "leonard.rogahn@hagenes.org", {address1: "71596 Eden Route", city: "Connellymouth", state: "LA", zipcode:"98872-9105"}]

      @customers.first.id.must_equal customers_first[0]
      @customers.first.email.must_equal customers_first[1]
      @customers.first.address.must_equal customers_first[2]

      customers_last = [35, "rogers_koelpin@oconnell.org", {address1: "7513 Kaylee Summit", city: "Uptonhaven", state: "DE", zipcode:"64529-2614"}]

      @customers.last.id.must_equal customers_last[0]
      @customers.last.email.must_equal customers_last[1]
      @customers.last.address.must_equal customers_last[2]
    end

  end

  describe "Customer.find" do
    it "Can find the first customer from the CSV" do
      Grocery::Customer.find(1).id.must_equal @customers.first.id
      Grocery::Customer.find(1).email.must_equal @customers.first.email
      Grocery::Customer.find(1).address.must_equal @customers.first.address

      # TODO: Your test code here!
    end

    it "Can find the last customer from the CSV" do
      Grocery::Customer.find(35).id.must_equal @customers.last.id
      Grocery::Customer.find(35).email.must_equal @customers.last.email
      Grocery::Customer.find(35).address.must_equal @customers.last.address

      # TODO: Your test code here!
    end

    it "Raises an error for an customer that doesn't exist" do
      proc {Grocery::Customer.find(300)}.must_raise ArgumentError
      # proc {Grocery::Customer.find(30)}.wont_raise ArgumentError
      # what the hell is proc?
      # TODO: Your test code here!


    end
  end
end
