require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/order'
# require '../support/orders'

describe "Order Wave 1" do
  describe "#initialize" do
    it "Takes an ID and collection of products" do
      id = 1337
      order = Grocery::Order.new(id, {})

      order.must_respond_to :id
      order.id.must_equal id
      order.id.must_be_kind_of Integer

      order.must_respond_to :products
      order.products.length.must_equal 0
    end
  end

  describe "#total" do
    it "Returns the total from the collection of products" do
      products = { "banana" => 1.99, "cracker" => 3.00 }
      order = Grocery::Order.new(1337, products)

      sum = products.values.inject(0, :+)
      expected_total = sum + (sum * 0.075).round(2)

      order.total.must_equal expected_total
    end

    it "Returns a total of zero if there are no products" do
      order = Grocery::Order.new(1337, {})

      order.total.must_equal 0
    end
  end

  describe "#add_product" do
    it "Increases the number of products" do
      products = { "banana" => 1.99, "cracker" => 3.00 }
      before_count = products.count
      order = Grocery::Order.new(1337, products)

      order.add_product("salad", 4.25)
      expected_count = before_count + 1
      order.products.count.must_equal expected_count
    end

    it "Is added to the collection of products" do
      products = { "banana" => 1.99, "cracker" => 3.00 }
      order = Grocery::Order.new(1337, products)

      order.add_product("sandwich", 4.25)
      order.products.include?("sandwich").must_equal true
    end

    it "Returns false if the product is already present" do
      products = { "banana" => 1.99, "cracker" => 3.00 }

      order = Grocery::Order.new(1337, products)
      before_total = order.total

      result = order.add_product("banana", 4.25)
      after_total = order.total

      result.must_equal false
      before_total.must_equal after_total
    end

    it "Returns true if the product is new" do
      products = { "banana" => 1.99, "cracker" => 3.00 }
      order = Grocery::Order.new(1337, products)

      result = order.add_product("salad", 4.25)
      result.must_equal true
    end
  end

  describe "remove product" do
    it "Decreases the number of products" do
      products = { "banana" => 1.99, "cracker" => 3.00 }
      before_count = products.count
      order = Grocery::Order.new(1337, products)

      order.remove_product("banana")
      expected_count = before_count - 1
      order.products.count.must_equal expected_count
    end

    it "Is removed from the collection of products" do
      products = { "banana" => 1.99, "cracker" => 3.00 }
      order = Grocery::Order.new(1337, products)

      order.remove_product("cracker")
      order.products.include?("cracker").must_equal false
    end

    it "Returns false if the product was not removed" do
      products = { "banana" => 1.99, "cracker" => 3.00 }
      order = Grocery::Order.new(1337, products)

      order.remove_product("banana")
      order.products.include?("banana").must_equal false
    end

  end

end

describe "Order Wave 2" do
# do a before do ... (piece of block code)  then do

  describe "Order.all" do
    #not sure how to show that
    it "Returns an array of all orders" do
      order = Grocery::Order.all

      order.length.must_equal 100
      order.must_be_instance_of Array
    end

    it "makes sure all in the array is an Order" do
      order = Grocery::Order.all
      order.each do |line|
        line.must_be_instance_of Grocery::Order
      end
    end

    it "Gives the correct number of orders" do
      order = Grocery::Order.all
      order.count.must_equal 100
      #check to see what length does?
    end

    it "Matches the ID and products of the first and last order with the CSV file" do
      order = Grocery::Order.all
      
      order.first.id.must_equal 1
      order.first.products.must_include "Wholewheat flour"

      order.last.id.must_equal 100
      order.last.products.must_include "Allspice"

    end

  end
end

  describe "Order.find" do
    it "Can find the first order from the CSV" do
      Grocery::Order.find(1).must_include "1"
      Grocery::Order.find(1).must_include "Slivered Almonds"
    end

    it "Can find the last order from the CSV" do
      Grocery::Order.find(100).must_include "100"
      Grocery::Order.find(100).must_include "Bran"

    end

    it "Raises an error for an order that doesn't exist" do
      proc {Grocery::Order.find(101)}.must_raise ArgumentError
      proc {Grocery::Order.find(0)}.must_raise ArgumentError
    end
  end
