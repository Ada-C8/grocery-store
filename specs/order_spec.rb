require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/order'

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
#
#   describe "#add_product" do
#     it "Increases the number of products" do
#       products = { "banana" => 1.99, "cracker" => 3.00 }
#       before_count = products.count
#       order = Grocery::Order.new(1337, products)
#
#       order.add_product("salad", 4.25)
#       expected_count = before_count + 1
#       order.products.count.must_equal expected_count
#     end
#
#     it "Is added to the collection of products" do
#       products = { "banana" => 1.99, "cracker" => 3.00 }
#       order = Grocery::Order.new(1337, products)
#
#       order.add_product("sandwich", 4.25)
#       order.products.include?("sandwich").must_equal true
#     end
#
#     it "Returns false if the product is already present" do
#       products = { "banana" => 1.99, "cracker" => 3.00 }
#
#       order = Grocery::Order.new(1337, products)
#       before_total = order.total
#
#       result = order.add_product("banana", 4.25)
#       after_total = order.total
#
#       result.must_equal false
#       before_total.must_equal after_total
#     end
#
#     it "Returns true if the product is new" do
#       products = { "banana" => 1.99, "cracker" => 3.00 }
#       order = Grocery::Order.new(1337, products)
#
#       result = order.add_product("salad", 4.25)
#       result.must_equal true
#     end
#   end
# end

# TODO: change 'xdescribe' to 'describe' to run these tests
describe "Order Wave 2" do
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

      Grocery::Order.all.must_be_kind_of Array
      Grocery::Order.all.length.must_equal 100

    end
  end

  describe "Order.find" do
    it "Can find the first order from the CSV" do
      Grocery::Order.all
      Grocery::Order.find(1).id.must_equal 1
      Grocery::Order.find(1).products[0].must_equal :name=>"Slivered Almonds", :price=>22.88
      Grocery::Order.find(1).products[1].keys.must_equal [:name, :price]
      Grocery::Order.find(1).products[1].values.must_equal ["Wholewheat flour", 1.93]

      # :name=>"Wholewheat flour", :price=>1.93

    end

    it "Can find the last order from the CSV" do
      Grocery::Order.all
      Grocery::Order.find(100).id.must_equal 100
      Grocery::Order.find(100).products[0].must_equal :name=>"Allspice", :price=>64.74
      Grocery::Order.find(100).products[1].must_equal :name=>"Bran", :price=>14.72
      Grocery::Order.find(100).products[1].keys.must_equal [:name, :price]
      Grocery::Order.find(100).products[1].values.must_equal ["Bran", 14.72]

    end

# {:name=>"Allspice", :price=>64.74

    it "Raises an error for an order that doesn't exist" do

      Grocery::Order.all
      proc {Grocery::Order.find(101)}.must_raise ArgumentError
    end

    end
  end
