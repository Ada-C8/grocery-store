require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/order'

order_list = "./support/orders.csv"
# online_order_list = "./support/online_orders.csv"
# test_groceries = Grocery::Order.all

describe "Order Wave 1" do
  describe "#initialize" do
    it "Takes an ID and collection of products" do
      id = 1337
      order = Grocery::Order.new(id, {"food" => 10.00})

      order.must_respond_to :id
      order.id.must_equal id
      order.id.must_be_kind_of Integer

      order.must_respond_to :products
      order.products.length.must_equal 1
      order.products.must_be_kind_of Hash
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
    it "Removes a product" do
      products = { "banana" => 1.99, "cracker" => 3.00 }
      order = Grocery::Order.new(1337, products)

      order.remove_product("banana")
      order.products.include?("banana").must_equal false
    end

    it "Returns true if product is removed" do
      products = { "banana" => 1.99, "cracker" => 3.00 }
      order = Grocery::Order.new(1337, products)

      result = order.remove_product("banana")
      result.must_equal true
    end

    it "Returns false is product is not removed" do
      products = { "banana" => 1.99, "cracker" => 3.00 }
      order = Grocery::Order.new(1337, products)

      result = order.remove_product("kiwi")
      result.must_equal false
    end
  end
end

# TODO: change 'xdescribe' to 'describe' to run these tests
describe "Order Wave 2" do
  test_groceries = Grocery::Order.all(order_list)

  describe "Order.all" do
    it "Returns an array of all orders" do
      # TODO: Your test code here!
      # Useful checks might include:
      #   - Order.all returns an array
      #   - Everything in the array is an Order
      #   - The number of orders is correct
      #   - The ID and products of the first and last
      #       orders match what's in the CSV file
      # Feel free to split this into multiple tests if needed
      test_groceries.must_be_kind_of Array

      test_groceries.each do |order|
        order.must_be_kind_of Grocery::Order
      end

      test_groceries.length.must_equal CSV.readlines("./support/orders.csv").size

      test_groceries.first.id.must_equal 1
      test_groceries.last.id.must_equal 100
    end
  end

  describe "Order.find" do
    it "Can return an Order" do
      Grocery::Order.find(1, test_groceries).must_be_kind_of Grocery::Order
    end

    it "Can find the first order from the CSV" do
      # puts Grocery::Order.all_orders.first
      Grocery::Order.find(1, test_groceries).must_equal test_groceries.first
    end

    it "Can find the last order from the CSV" do
      # TODO: Your test code here!
      Grocery::Order.find(100, test_groceries).must_equal test_groceries.last
    end

    it "Raises an error for an order that doesn't exist" do
      # TODO: Your test code here!
      proc {Grocery::Order.find(1000000, test_groceries)}.must_raise RangeError
    end
  end
end
