require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require 'pry'
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

  describe "remove_product" do
    it "Decreases the number of products" do

      products = { "banana" => 1.99, "cracker" => 3.00, "salad" => 4.25}
      before_count = products.count
      order = Grocery::Order.new(1337, products)

      order.remove_product("salad")
      expected_count = before_count - 1
      order.products.count.must_equal expected_count
    end

    it "Is removed from the collection of products" do
      products = { "banana" => 1.99, "cracker" => 3.00, "sandwich" => 4.25 }
      order = Grocery::Order.new(1337, products)

      order.remove_product("sandwich")
      order.products.include?("sandwich").must_equal false
    end

    it "Returns false if the product doesn't exist in collection of prodcuts AKA cannot remove something that doesn't exits" do
      products = { "banana" => 1.99, "cracker" => 3.00 }
      order = Grocery::Order.new(1337, products)

      result = order.remove_product("apple")
      result.must_equal false
    end

    it "Returns true if the product is was present" do
      products = { "banana" => 1.99, "cracker" => 3.00 }
      order = Grocery::Order.new(1337, products)

      result = order.remove_product("banana")
      result.must_equal true
    end

  end

end

# TODO: change 'xdescribe' to 'describe' to run these tests
describe "Order Wave 2" do
  # before do
  #   @orders = Grocery::Order.all
  # end
  describe "Order.all" do
    #   - Everything in the array is an Order
    it "Returns an array of all orders" do
      Grocery::Order.all.each do |order|
        order.must_be_kind_of Grocery::Order
      end
    end
    it "Order.all returns an array" do
      Grocery::Order.all.must_be_kind_of Array
    end

    it "the number of orders is correct" do
      Grocery::Order.all.length.must_equal 100
    end

    it "the ID and products of order.all[0] and order.all[99] match what is in the CSV file" do
      order_first = [1, {"Slivered Almonds" => 22.88, "Wholewheat flour" => 1.93, "Grape Seed Oil" => 74.9}]
      order_last = [100, {"Allspice" => 64.74, "Bran" => 14.72, "UnbleachedFlour" => 80.59}]
      # you have to call orders.first.id because orders is an array of instances of the class. You need to get down to the first instance in the array to call the class instance variable on it.
      Grocery::Order.all.first.id.must_equal order_first[0]
      Grocery::Order.all.first.products.must_equal order_first[1]
      Grocery::Order.all.last.id.must_equal order_last[0]
      Grocery::Order.all.last.products.must_equal order_last[1]
    end
  end

  describe "Order.find" do
    it "Can find the first order from the CSV" do
      Grocery::Order.find(1).must_be_same_as Grocery::Order.all.first
    end

    it "Can find the last order from the CSV" do
      Grocery::Order.find(100).must_be_same_as Grocery::Order.all.last
    end

    it "Raises an error for an order that doesn't exist" do
      proc{Grocery::Order.find(107)}.must_raise ArgumentError
    end
  end
end
