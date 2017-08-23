require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/order'

# adding for color
reporter_options = { color: true }
Minitest::Reporters.use! Minitest::Reporters::DefaultReporter.new(reporter_options)
#Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new


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
      @products = { "banana" => 1.99, "cracker" => 3.00, "salad" => 4.25 }
      @order = Grocery::Order.new(1337, @products)
    end

    it "Decreases the number of products" do
      before_count = @products.count

      @order.remove_product("banana")
      expected_count = before_count - 1
      @order.products.count.must_equal expected_count
    end

    it "Is removed from the collection of products" do
      @order.remove_product("cracker")
      @order.products.include?("cracker").must_equal false
    end

    it "Returns true if the product is in the collection" do
      result = @order.remove_product("salad")
      result.must_equal true
    end

    it "Returns false if the product is not in the collection" do
      result = @order.remove_product("chips")
      result.must_equal false
    end
  end
end

# TODO: change 'xdescribe' to 'describe' to run these tests
describe "Order Wave 2" do
  describe "Order.all" do
    before do
      @all_orders = Grocery::Order.all
    end
    it "Returns an array of all orders" do
      @all_orders.must_be_instance_of Array

      @all_orders.each do |order|
        order.must_be_instance_of Grocery::Order
      end
    end

    # 100 orders in csv file
    it "Returns same number of orders as in csv file" do
      num_orders = 100 # this is num orders in csv file
      @all_orders.length.must_equal num_orders
    end

    it "Product id and info of first order match CSV file" do
      first_product = @all_orders[0]

      expected_id = 1
      expected_products = { "Slivered Almonds" => 22.88,
                            "Wholewheat flour" => 1.93,
                            "Grape Seed Oil" => 74.9 }

      first_product.id.must_equal expected_id
      first_product.products.must_equal expected_products
    end

    it "Product id and info of last order match CSV file" do
      last_product = @all_orders[@all_orders.length - 1]

      expected_id = 100
      expected_products = { "Allspice" => 64.74,
                            "Bran" => 14.72,
                            "UnbleachedFlour" => 80.59 }

      last_product.id.must_equal expected_id
      last_product.products.must_equal expected_products
    end

  end

  describe "Order.find" do

    it "Can find the first order from the CSV" do
      expected_id = 1
      expected_products = { "Slivered Almonds" => 22.88,
                          "Wholewheat flour" => 1.93,
                          "Grape Seed Oil" => 74.9 }

      first_order = Grocery::Order.find(1)
      first_id = first_order.id
      first_products = first_order.products

      first_id.must_equal expected_id
      first_products.must_equal expected_products
    end

    it "Can find the last order from the CSV" do
      expected_id = 100
      expected_products = { "Allspice" => 64.74,
                            "Bran" => 14.72,
                            "UnbleachedFlour" => 80.59 }

      last_order = Grocery::Order.find(100)
      last_id = last_order.id
      last_products = last_order.products

      last_id.must_equal expected_id
      last_products.must_equal expected_products
    end

    it "Raises an error for an order that doesn't exist" do
      Grocery::Order.find(500).must_be_nil
    end
  end
end
