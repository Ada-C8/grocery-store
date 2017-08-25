require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require 'pry'
require_relative '../lib/customer'
# TODO: uncomment the next line once you start wave 3
# require_relative '../lib/customer'
# 1,leonard.rogahn@hagenes.org,71596 Eden Route,Connellymouth,LA,98872-9105
describe "Customer" do
  describe "#initialize" do
    #"leonard.rogahn@hagenes.org", "71596 Eden Route,Connellymouth,LA,98872-9105")
    # {address1: , city: , state: , zipcode: }
    it "Takes an ID, email and address info" do
      customer = Grocery::Customer.new(1, "leonard.rogahn@hagenes.org", {address1: "71596 Eden Route" , city: "Connellymouth" , state: "LA", zip_code: "98872-9105" })

      address = {:address1=>"71596 Eden Route", :city=>"Connellymouth",:state=>"LA", :zip_code=>"98872-9105"}

      customer.must_respond_to :id && :email && :address
      customer.id.must_equal 1
      customer.email.must_equal "leonard.rogahn@hagenes.org"
      customer.address.must_equal address
    end
  end

  # TODO: Your test code here!
  # Useful checks might include:
  #   - Customer.all returns an array
  #   - Everything in the array is a Customer
  #   - The number of orders is correct
  #   - The ID, email address of the first and last
  #       customer match what's in the CSV file
  # Feel free to split this into multiple tests if needed
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

    #this could be more efficient test
    it "the ID email and address customers.all[0] and customers.all[35] match what is in the CSV file" do
      customer_one = Grocery::Customer.new(1, "leonard.rogahn@hagenes.org", {address1: "71596 Eden Route" , city: "Connellymouth" , state: "LA", zip_code: "98872-9105" })
      # binding.pry
      customer = Grocery::Customer.all
      customer.first.id.must_equal customer_one.id

      Grocery::Customer.all.first.email.must_equal customer_one.email

      Grocery::Customer.all.first.email.must_equal customer_one.address

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
