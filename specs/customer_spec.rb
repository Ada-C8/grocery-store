require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require 'csv'

# TODO: uncomment the next line once you start wave 3
require_relative '../lib/customer'

describe "Customer" do
  describe "#initialize" do
    it "Takes an ID, email and address info" do
      id = 234
	  email = 'tapir@happymail.com'
	  address = '123 Internet Street'
	  city = 'seattle'
	  state = 'WA'
	  zip = '98101'
	  
	  customer = Grocery::Customer.new(id, email, address, city, state, zip)
	  
	  customer.must_respond_to :id
	  customer.id.must_equal id
	  customer.id.must_be_kind_of Integer
	  
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
		a = Grocery::Customer.all
		
		a.must_be_kind_of Array
		
		a.each { |i|
			i.must_be_kind_of Grocery::Customer
		}
		
    end
  end
  

  describe "Customer.find" do
    

    it "Can find the last customer from the CSV" do
      # TODO: Your test code here!
    end

    it "Raises an error for a customer that doesn't exist" do
      # TODO: Your test code here!
    end
  end

end
