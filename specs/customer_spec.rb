require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/customer.rb'
require_relative '../lib/order.rb'
require_relative '../lib/online-order.rb'
require 'csv'

# TODO: uncomment the next line once you start wave 3
# require_relative '../lib/customer'

describe "Customer" do

  before do

  end

  describe "#initialize" do
    it "Takes an ID, email and address info" do
      marcel = Grocery::Customer.new(12, "marcel@alexandchristiane.com", "1400 60th street, 98107 Seattle, WA")
      marcel.must_be_instance_of Grocery::Customer

      walter = Grocery::Customer.new(CSV.read('./support/customers.csv').first[0], CSV.read('./support/customers.csv').first[1], CSV.read('./support/customers.csv').first[2..-2])
      walter.must_be_instance_of Grocery::Customer
    end
  end

  describe "Customer.all" do
    it "Returns an array of all customers" do
      #   - Customer.all returns an array
      Grocery::Customer.all.must_be_kind_of Array

      #   - Everything in the array is a Customer
      Grocery::Customer.all.each do |customer|
        customer.must_be_instance_of Grocery::Customer
      end

      #   - The number of orders is correct

      #   - The ID, email address of the first and last
      #       customer match what's in the CSV file
      Grocery::Customer.all.first.id.must_equal CSV.read('./support/customers.csv').first[0]
      Grocery::Customer.all.last.id.must_equal CSV.read('./support/customers.csv').last[0]
      Grocery::Customer.all.first.email.must_equal CSV.read('./support/customers.csv').first[1]
      Grocery::Customer.all.last.email.must_equal CSV.read('./support/customers.csv').last[1]
      Grocery::Customer.all.first.address.must_equal CSV.read('./support/customers.csv').first[2..-2]
      Grocery::Customer.all.last.address.must_equal CSV.read('./support/customers.csv').last[2..-2]
    end
  end

  describe "Customer.find" do
    it "Can find the first customer from the CSV" do
        min_id = 2
        Grocery::Customer.all.each do |customer|
          if customer.id.to_i < min_id
            min_id = customer.id.to_i
          end
        end
      Grocery::Customer.find(min_id.to_s).id.must_equal Grocery::Customer.new(CSV.read('./support/customers.csv').first[0], CSV.read('./support/customers.csv').first[1], CSV.read('./support/customers.csv').first[2..-2]).id
      Grocery::Customer.find(min_id.to_s).email.must_equal Grocery::Customer.new(CSV.read('./support/customers.csv').first[0], CSV.read('./support/customers.csv').first[1], CSV.read('./support/customers.csv').first[2..-2]).email
      Grocery::Customer.find(min_id.to_s).address.must_equal Grocery::Customer.new(CSV.read('./support/customers.csv').first[0], CSV.read('./support/customers.csv').first[1], CSV.read('./support/customers.csv').first[2..-2]).address
    end

    it "Can find the last customer from the CSV" do
      max_id = 0
      Grocery::Customer.all.each do |customer|
        if customer.id.to_i > max_id
          max_id = customer.id.to_i
        end
      end
      Grocery::Customer.find(max_id.to_s).id.must_equal Grocery::Customer.new(CSV.read('./support/customers.csv').last[0], CSV.read('./support/customers.csv').last[1], CSV.read('./support/customers.csv').last[2..-2]).id
      Grocery::Customer.find(max_id.to_s).email.must_equal Grocery::Customer.new(CSV.read('./support/customers.csv').last[0], CSV.read('./support/customers.csv').last[1], CSV.read('./support/customers.csv').last[2..-2]).email
      Grocery::Customer.find(max_id.to_s).address.must_equal Grocery::Customer.new(CSV.read('./support/customers.csv').last[0], CSV.read('./support/customers.csv').last[1], CSV.read('./support/customers.csv').last[2..-2]).address
    end

    it "Raises an error for a customer that doesn't exist" do
      # TODO: Your test code here!
      max_id = 0
      Grocery::Customer.all.each do |customer|
        if customer.id.to_i > max_id
          max_id = customer.id.to_i
        end
      end
      max_id +=1
      proc {Grocery::Customer.find(max_id.to_s)}.must_raise ArgumentError
    end
  end
end
