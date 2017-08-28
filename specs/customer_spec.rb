require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'

# TODO: uncomment the next line once you start wave 3
require_relative '../lib/customer'

describe "Customer" do
  describe "#initialize" do
    it "Takes an ID, email and address info" do
      id = 666
      email = "sugarcreek@puppers.com"
      address = "1313 4 Paws Lane"
      customer = Grocery::Customer.new(id, email, address)

      customer.must_respond_to :id
      customer.id.must_equal id
      customer.id.must_be_kind_of Integer

      customer.must_respond_to :email
      customer.email.must_equal email

      customer.must_respond_to :address
      customer.address.must_equal address
    end
  end

  describe "Customer.all" do
    # TODO: Your test code here!
    # Useful checks might include:
    #   - Customer.all returns an array
    #   - Everything in the array is a Customer
    #   - The number of orders is correct
    #   - The ID, email address of the first and last
    #       customer match what's in the CSV file
    # Feel free to split this into multiple tests if needed
    it "Returns an Array when Customer.all is called" do
      Grocery::Customer.all.must_be_kind_of Array
    end

    it "Verifies the number of customers is correct" do
      total_customers = CSV.read("support/customers.csv", 'r').length
      Grocery::Customer.all.length.must_equal total_customers
    end

    it "Verifies everything in the Array is a Customer" do
      Grocery::Customer.all.each do |customer|
        customer.must_be_kind_of Grocery::Customer
      end
    end

    xit "Matches the ID and products of the first and last orders with what's in the CSV file" do

      Grocery::Order.all[1].id.must_equal 1
      expected_order = {"Slivered Almonds"=>"22.88", "Wholewheat flour"=>"1.93", "Grape Seed Oil"=>"74.9"}
      Grocery::Order.all[1].products.must_equal expected_order


      Grocery::Order.all[100].id.must_equal 100
      expected_order = {"Allspice"=>"64.74", "Bran"=>"14.72", "UnbleachedFlour"=>"80.59"}
      Grocery::Order.all[100].products.must_equal expected_order
    end


    describe "Customer.find" do
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
end
