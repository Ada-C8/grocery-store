require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/costumer'


# TODO: uncomment the next line once you start wave 3
# require_relative '../lib/customer'

describe "Customer" do
  describe "#initialize" do
    it "Takes an ID, email and address info" do

      id = 123
      email = "bartsimpson@gmail.com"
      costumer= Grocery::Costumer.new(id, email, {})

      costumer.must_respond_to :id
      costumer.id.must_equal id
      costumer.id.must_be_kind_of Integer

      costumer.must_respond_to :email
      costumer.email.must_equal email
      costumer.email.must_be_kind_of String

      costumer.must_respond_to :address
      costumer.address.length.must_equal 0
    end
  end

  describe "Customer.all" do
    it "Returns an array of all customers" do

      infopeople = Grocery::Costumer.all
      #   - Customer.all returns an array
      infopeople.must_be_kind_of Array
      #   - Everything in the array is a Customer
      infopeople.each do |person|
        person.must_be_kind_of Grocery::Costumer
      end
      #   - The number of orders is correct
      infopeople.length.must_equal  35
      #   - The ID, email address of the first and last
      #       customer match what's in the CSV file
      firstperson = Grocery::Costumer.new(1,"leonard.rogahn@hagenes.org",{"Address 1" => "71596 Eden Route", "City" => "Connellymouth", "State"=> "LA", "Zip-Code" => "98872-9105"})
      infopeople[0].id.must_equal firstperson.id
      infopeople[0].email.must_equal firstperson.email
      infopeople[0].address.must_equal firstperson.address

      lastperson = Grocery::Costumer.new(35,"rogers_koelpin@oconnell.org",{"Address 1" => "7513 Kaylee Summit" ,"City" => "Uptonhaven", "State" => "DE", "Zip-Code" => "64529-2614"})
      infopeople[-1].id.must_equal lastperson.id
      infopeople[-1].email.must_equal lastperson.email
      infopeople[-1].address.must_equal lastperson.address
    end
  end

  describe "Customer.find" do
    it "Can find the first customer from the CSV" do
      # TODO: Your test code here!
      firstperson = Grocery::Costumer.new(1,"leonard.rogahn@hagenes.org",{"Address 1" => "71596 Eden Route", "City" => "Connellymouth", "State"=> "LA", "Zip-Code" => "98872-9105"})
      Grocery::Costumer.find(1).id.must_equal firstperson.id
      Grocery::Costumer.find(1).email.must_equal firstperson.email
      Grocery::Costumer.find(1).address.must_equal firstperson.address
    end

    it "Can find the last customer from the CSV" do
      lastperson = Grocery::Costumer.new(35,"rogers_koelpin@oconnell.org",{"Address 1" => "7513 Kaylee Summit" ,"City" => "Uptonhaven", "State" => "DE", "Zip-Code" => "64529-2614"})
      Grocery::Costumer.find(35).id.must_equal lastperson.id
      Grocery::Costumer.find(35).email.must_equal lastperson.email
      Grocery::Costumer.find(35).address.must_equal lastperson.address
    end

    it "Raises an error for a customer that doesn't exist" do
      proc{Grocery::Costumer.find(400).must_raise ArgumentError}
    end
  end
end
