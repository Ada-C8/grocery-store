require 'minitest/autorun'
require 'minitest/pride'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/order'
require 'csv'


xdescribe "Order Wave 1" do
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

  describe "#remove_product" do
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

      order.remove_product("banana")
      order.products.include?("banana").must_equal false
    end

    it "Returns true if the item was removed" do
      products = { "banana" => 1.99, "cracker" => 3.00 }
      order = Grocery::Order.new(1337, products)

      result = order.remove_product("banana")
      result.must_equal true
    end

    it "Returns false if it was not removed/did not exist" do
      products = { "banana" => 1.99, "cracker" => 3.00 }

      order = Grocery::Order.new(1337, products)
      before_total = order.total

      result = order.remove_product("pineapple")
      after_total = order.total

      result.must_equal false
      before_total.must_equal after_total
    end

  end

end

xdescribe "Order Wave 2" do
  before do
    Grocery::Order.clear
  end
  describe "Order.all" do
    it "Returns an array of all orders" do
      Grocery::Order.all.must_be_kind_of Array

      Grocery::Order.all[rand(0..(Grocery::Order.all.length - 1))].must_be_kind_of Grocery::Order

      Grocery::Order.all.length.must_equal       CSV.read('support/orders.csv').length
    end

    it "Returns the ID and products of an order as from .csv data set" do

      #Testing for first CSV order
      Grocery::Order.all[0].id.must_equal CSV.read('support/orders.csv')[0][0]
      order_1_array =

      CSV.read('support/orders.csv')[0][1].gsub(":",";").split(";")
      Grocery::Order.all[0].products.each do |hash|
        hash.each do |k,v| #
          order_1_array.delete(k)
          order_1_array.delete(v)
        end
      end
      order_1_array.must_equal []

      #Testing for first CSV order
      Grocery::Order.all[-1].id.must_equal CSV.read('support/orders.csv')[-1][0]
      order_1_array =

      CSV.read('support/orders.csv')[-1][1].gsub(":",";").split(";")
      Grocery::Order.all[-1].products.each do |hash|
        hash.each do |k,v| #
          order_1_array.delete(k)
          order_1_array.delete(v)
        end
      end
      order_1_array.must_equal []
    end

    # Useful checks might include:
    #   X Order.all returns an array
    #   X Everything in the array is an Order
    #   X The number of orders is correct
    #   X The ID and products of the first and last
    #       orders match what's in the CSV file
  end

  describe "Order.find" do
    before do
      Grocery::Order.all
    end

    it "Can find the first order from the CSV" do
      Grocery::Order.find(0).must_be_kind_of Grocery::Order

      Grocery::Order.find(0).id.must_equal CSV.read('support/orders.csv')[0][0]
    end

    it "Can find the last order from the CSV" do
      Grocery::Order.find(-1).must_be_kind_of Grocery::Order

      Grocery::Order.find(-1).id.must_equal CSV.read('support/orders.csv')[-1][0]
    end

    it "Raises an error for an order that doesn't exist" do
      proc {Grocery::Order.find(Grocery::Order.all.length)}.must_raise ArgumentError
    end
  end

end
