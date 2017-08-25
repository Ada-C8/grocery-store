require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require 'pry'
require_relative '../lib/customer'
# TODO: uncomment the next line once you start wave 3
# require_relative '../lib/customer'
# 1,leonard.rogahn@hagenes.org,71596 Eden Route,Connellymouth,LA,98872-9105
describe "Customer" do
  before do
    @customer_first = Grocery::Customer.new(1, "leonard.rogahn@hagenes.org", {address1: "71596 Eden Route" , city: "Connellymouth" , state: "LA", zip_code: "98872-9105" })
    @customer_last = Grocery::Customer.new(35, "rogers_koelpin@oconnell.org", {address1: "7513 Kaylee Summit" , city: "Uptonhaven" , state: "DE", zip_code: "64529-2614" })
  end
  describe "#initialize" do
    #"leonard.rogahn@hagenes.org", "71596 Eden Route,Connellymouth,LA,98872-9105")
    # {address1: , city: , state: , zipcode: }
    it "Takes an ID, email and address info" do
      # customer = Grocery::Customer.new(1, "leonard.rogahn@hagenes.org", {address1: "71596 Eden Route" , city: "Connellymouth" , state: "LA", zip_code: "98872-9105" })

      address = {:address1=>"71596 Eden Route", :city=>"Connellymouth",:state=>"LA", :zip_code=>"98872-9105"}

      @customer_first.must_respond_to :id && :email && :address
      @customer_first.id.must_equal 1
      @customer_first.email.must_equal "leonard.rogahn@hagenes.org"
      @customer_first.address.must_equal address
    end
  end

  describe "Customer.all" do
    it "Customer.all returns an array" do
      Grocery::Customer.all.must_be_kind_of Array
    end

    it "Everything in the array is of class customer" do
      Grocery::Customer.all.each do |customer|
        customer.must_be_kind_of Grocery::Customer
      end
    end

    it "Customer.all returns and array with the correct number of customers" do
      Grocery::Customer.all.length.must_equal 35
    end

    it "the ID email and address customers.all[0] and customers.all[35] match what is in the CSV file" do
      Grocery::Customer.all.first.id.must_equal @customer_first.id
      Grocery::Customer.all.first.address.must_equal @customer_first.address
      Grocery::Customer.all.first.email.must_equal @customer_first.email
      Grocery::Customer.all.last.id.must_equal @customer_last.id
      Grocery::Customer.all.last.address.must_equal @customer_last.address
      Grocery::Customer.all.last.email.must_equal @customer_last.email
    end
  end

  describe "Customer.find" do
    it "Can find the first customer from the CSV" do
      Grocery::Customer.find(1).id.must_equal @customer_first.id
      Grocery::Customer.find(1).email.must_equal @customer_first.email      Grocery::Customer.find(1).address.must_equal @customer_first.address

    end

    it "Can find the last customer from the CSV" do
      Grocery::Customer.find(35).last.id.must_equal @customer_last.id
      Grocery::Customer.find(35).last.address.must_equal @customer_last.address
      Grocery::Customer.find(35).last.email.must_equal @customer_last.email
    end

    it "Raises an error for a customer that doesn't exist" do
      proc{Grocery::Customer.find(100)}.must_raise ArgumentError
    end
  end
end
