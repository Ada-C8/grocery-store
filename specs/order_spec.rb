require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
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
    before do
      products = { "banana" => 1.99, "cracker" => 3.00 }
      @order = Grocery::Order.new(1337, products)
    end

    it "Decreases the number of products" do
      before_count = @order.products.keys.length
      @order.remove_product("banana")
      expected_count = before_count - 1
      @order.products.count.must_equal expected_count
    end

    it "Is removed from the collection of products" do
      @order.remove_product("banana")
      @order.products.keys.wont_include "banana"
    end

    it "Returns true if the product has been successfully deleted from products" do
      result = @order.remove_product("banana")
      result.must_equal true
    end

    it "Returns false if the product cannot be removed/doesn't exist in products" do
      result = @order.remove_product("salad")
      result.must_equal false
    end
  end
end

# TODO: change 'xdescribe' to 'describe' to run these tests
describe "Order Wave 2" do

  describe "Order.all" do
    it "Returns an array of all orders" do
      # TODO: Your test code here!
      # Useful checks might include:
      Grocery::Order.all.must_be_instance_of Array
      #   - Everything in the array is an Order
      Grocery::Order.all[0].must_be_instance_of Grocery::Order
      #   - The number of orders is correct
      Grocery::Order.all.length.must_equal 100
      #   - The ID and products of the first and last
      #       orders match what's in the CSV file
      first_order = CSV.read("support/orders.csv")[0]#first_order = [id, item:price;item;price]
      Grocery::Order.all[0].id.must_equal first_order[0].to_i
      product_names_in_hash = Grocery::Order.all[0].products.keys
      # Find if each item in product hash is in the String of products from CSV
      product_names_in_hash.each do |item|
        first_order[1].include?(item).must_equal true
      end

      # Feel free to split this into multiple tests if needed
    end
  end

  describe "Order.find" do
    it "Can find the first order from the CSV" do
      # TODO: Your test code here!
      Grocery::Order.find(1).must_be_instance_of Grocery::Order

    end

    it "Can find the last order from the CSV" do
      # TODO: Your test code here!
      Grocery::Order.find(100).must_be_instance_of Grocery::Order
    end

    it "Raises an error for an order that doesn't exist" do
      # TODO: Your test code here!
      proc { Grocery::Order.find(101) }.must_raise ArgumentError
    end
  end
end
