require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'

# TODO: uncomment the next line once you start wave 3
 require_relative '../lib/customer'

  #passed before, marked as xdescribe because it didn't change the line outcome
describe "Customer" do
  describe "#initialize" do
    it "Takes an ID, email and address info" do
      # TODO: Your test code here!

      id = 123
      email = "pikachu@poke.mon"
      address = "123 Niantic, Redmond, WA 98052"
      customer = Grocery::Customer.new(id, email, address)

      # THIS WORKS
      # puts customer
      # array = []
      # array << customer
      # array.each do |check|
      #   puts check.id
      #   puts check.email
      #   puts check.address
      # end

      customer.must_respond_to :id
      customer.id.must_equal id
      customer.id.must_be_kind_of Integer

      customer.must_respond_to :email
      customer.email.must_equal email
      customer.email.must_be_kind_of String

      customer.must_respond_to :address
      customer.address.must_equal address
      customer.address.must_be_kind_of String
    end
  end


  describe "Customer.all" do
    it "Returns an array of all customers" do
      # TODO: Your test code here!
      # Useful checks might include:
      #   - Customer.all returns an array
      #   - Everything in the array is a Customer
      #   - The number of orders is correct
      #   - The ID, email address of the first and last
      #       customer match what's in the CSV file
      # Feel free to split this into multiple tests if needed
      all_customers = Grocery::Customer.all

      # THIS WORKS
      # all_customers.each do |check|
      #   print "#{check.id} "
      # end

      all_customers.must_be_instance_of Array
    end
  end

  describe "Customer.find" do
    it "Can find the first customer from the CSV" do
      # TODO: Your test code here!
      first_customer = Grocery::Customer.find(1)

      # # THIS WORKS
      # puts "first customer: #{first_customer}"
      # array = []
      # array << first_customer
      # array.each do |check|
      #   puts "#{check.id}, #{check.email}, #{check.address}"
      # end

      #assert
      first_customer.must_be_instance_of Grocery::Customer
    end

    it "Can find the last customer from the CSV" do
      # TODO: Your test code here!

      last = Grocery::Customer.all.count
      last_customer = Grocery::Customer.find(last)

      # # THIS WORKS
      # puts last
      # puts "last customer: #{last_customer}"
      # array = []
      # array << last_customer
      # array.each do |check|
      #   puts "#{check.id}, #{check.email}, #{check.address}"
      # end

      #assert
      last_customer.must_be_instance_of Grocery::Customer
    end

    it "Raises an error for a customer that doesn't exist" do
      # TODO: Your test code here!

      # # THIS WORKS
      # puts Grocery::Customer.find(0)

      proc {Grocery::Customer.find(-20)}.must_raise ArgumentError
      proc {Grocery::Customer.find(0)}.must_raise ArgumentError
      proc {Grocery::Customer.find(36)}.must_raise ArgumentError
      proc {Grocery::Customer.find(1000)}.must_raise ArgumentError
    end
  end
end
