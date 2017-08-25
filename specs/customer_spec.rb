require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
# TO-DO: uncomment the next line once you start wave 3
require_relative '../lib/customer'

xdescribe "Customer" do
  describe "#initialize" do
    it "Takes an ID, email and address info" do
      
    end
  end

  describe "Customer.all" do
    # Your test code here!
    # Useful checks might include:
    #   - Customer.all returns an array
    #   - Everything in the array is a Customer
    #   - The number of orders is correct
    #   - The ID, email address of the first and last
    #       customer match what's in the CSV file
    # Feel free to split this into multiple tests if needed

    it "Returns an array of all customers" do
      customers = Grocery::Customer.all

      customers.class.must_equal Array
    end

    it "Everything in the returned array is a Customer" do
      customers = Grocery::Customer.all

      all_records_are_customers = true
      customers.each do |order|
        # puts Customer.class to confirm class name
        if customers.class != Grocery::Customer
          all_records_are_customers = false
        end
      end

      all_records_are_customers.must_equal true
    end

    it "Returns the correct number of customers" do
      customers = Grocery::Customer.all

      customers.length.must_equal 35
    end

    it "Confirms the first customer info matches CSV file info" do
      customers = Grocery::Customer.all

      first_customer_id = 1
      first_customer_email = "leonard.rogahn@hagenes.org"

      customers[0].customer_id.must_equal(first_customer_id) && customers[0].email_address.must_equal(first_customer_email)
    end

    it "Confirms the last customer id & email matches CSV file info" do
      customers = Grocery::Customer.all

      last_customer_id = 35
      last_customer_email = "rogers_koelpin@oconnell.org"

      customers[34].customer_id.must_equal(last_customer_id) && customers[34].email_address.must_equal(last_customer_email)
    end

  end

  xdescribe "Customer.find" do
    xit "Can find the first customer from the CSV" do
      # TODO: Your test code here!
    end

    xit "Can find the last customer from the CSV" do
      # TODO: Your test code here!
    end

    xit "Raises an error for a customer that doesn't exist" do
      # TODO: Your test code here!
    end
  end
end
