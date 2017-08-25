require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require 'minitest/pride'
require_relative '../lib/order'
require 'csv'

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
      #raise argument error if id or order is a negative number

      it "Raises an ArgumentError for invalid parameters" do
        proc {Grocery::Order.new(-1, {})}.must_raise ArgumentError
        proc {Grocery::Order.new(123, -2)}.must_raise ArgumentError
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

  describe "#remove product" do
    it "Decreases the number of products" do
      products = { "banana" => 1.99, "cracker" => 3.00 }
      order = Grocery::Order.new(1337, products)
      order.remove_product("banana")
      order.products.length.must_equal 1
    end

    it "Returns true if the product was successfully removed" do
      products = { "banana" => 1.99, "cracker" => 3.00 }
      order = Grocery::Order.new(1337, products)
      result = order.remove_product("banana")
      result.must_equal true
    end

    it "Returns false if the product was not removed" do
      products = { "banana" => 1.99, "cracker" => 3.00 }
      order = Grocery::Order.new(1337, products)
      result = order.remove_product("spinach")
      result.must_equal false
    end

  end
end

# To do: change 'xdescribe' to 'describe' to run these tests
describe "Order Wave 2" do

  before do
    @orders = Grocery::Order.all
  end

  describe "Order.all" do
    it "Returns an array of all orders" do
      @orders.must_be_kind_of Array
    end

    it "Everything in the array is an Order" do
      @orders.each do |order|
        order.must_be_kind_of Grocery::Order
      end
    end

    it "The number of orders is correct" do
      # @orders.length.must_equal 100
      @orders.length.must_equal @orders[-1].id
    end

    it "The ID and products of the first and last orders match what's in the CSV file" do

      # @orders[0].id.must_equal 1
      first_line = ["1","Slivered Almonds:22.88;Wholewheat flour:1.93;Grape Seed Oil:74.9"]
      id = first_line[0].to_i
      products_arr = first_line[1].split(';')
      products = Hash[products_arr.map { |i| i.split(":") }]
      products = Hash[products.keys.zip(products.values.map(&:to_f))]

      # Grocery::Order.new(id, products)

      @orders[0].id.must_equal id
      @orders[0].products.must_equal products

      last_line = ["100","Allspice:64.74;Bran:14.72;UnbleachedFlour:80.59"]
      id = last_line[0].to_i
      products_arr = last_line[1].split(';')
      products = Hash[products_arr.map { |i| i.split(":") }]
      products = Hash[products.keys.zip(products.values.map(&:to_f))]

      @orders[-1].id.must_equal id
      @orders[-1].products.must_equal products
    end
  end

  describe "Order.find" do

    it "Can find the first order from the CSV" do
      @orders_2 = Grocery::Order.find(1)
      @orders_2.id.must_equal 1
    end

    it "Can find the last order from the CSV" do
      @orders_2 = Grocery::Order.find(100)
      @orders_2.id.must_equal 100

    end

    it "Raises an error for an order that doesn't exist" do
      proc {Grocery::Order.find(101)}.must_raise ArgumentError
      proc {Grocery::Order.find(-1)}.must_raise ArgumentError
      proc {Grocery::Order.find(0)}.must_raise ArgumentError
    end
  end
end
