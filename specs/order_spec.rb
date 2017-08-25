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
end

# TODO: change 'xdescribe' to 'describe' to run these tests
describe "Order Wave 2" do
  describe "Order.all" do

    it "Returns a Hash when Order.all is called" do
      Grocery::Order.all.must_be_kind_of Hash
    end

    xit "Returns a Hash of all orders" do
      products = { "cat" => 2 }
      order_1 = Grocery::Order.new(1313, products)
      order_2 = Grocery::Order.new(666, products)

      expected_orders = {order_1.id => order_1.products, order_2.id => order_2.products}
      Grocery::Order.all.must_equal expected_orders
    end

    xit "Verifies the number of orders is correct" do
      products = { "cat" => 2 }
      Grocery::Order.new(1313, products)
      Grocery::Order.new(666, products)

      Grocery::Order.all.length.must_equal 2
    end

    xit "Verifies everything in the Hash is an Order" do
      products = { "cat" => 2 }
      Grocery::Order.new(1313, products)
      Grocery::Order.new(666, products)

      Grocery::Order.all.each do |order|
        order[1].must_be_kind_of Grocery::Order
      end
    end

    xit "Matches the ID and products of the first and last orders with what's in the CSV file" do
      Grocery::Order.read_orders("support/orders.csv") #only works if test is run from its main dir :(

      Grocery::Order.all[1].id.must_equal 1 # key 1, not index 1
      expected_products = {"Slivered Almonds"=>"22.88", "Wholewheat flour"=>"1.93", "Grape Seed Oil"=>"74.9"}
      Grocery::Order.all[1].products.must_equal expected_products

      Grocery::Order.all[100].id.must_equal 100 # key 100, not index 100
      expected_products = {"Allspice"=>"64.74", "Bran"=>"14.72", "UnbleachedFlour"=>"80.59"}
      Grocery::Order.all[100].products.must_equal expected_products
    end
  end

  describe "Order.find" do
    it "Can find the first order from the CSV" do
      # TODO: Your test code here!
    end

    it "Can find the last order from the CSV" do
      # TODO: Your test code here!
    end

    it "Raises an error for an order that doesn't exist" do
      # TODO: Your test code here!
    end
  end
end
