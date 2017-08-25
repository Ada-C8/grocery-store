require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require 'minitest/pride'
require_relative '../lib/order'
require 'pry'

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

  describe "#remove product" do

    it "Decreases the number of products" do
      products = { "banana" => 1.99, "cracker" => 3.00, "salad" => 4.25 }
      before_count = products.count
      order = Grocery::Order.new(1337, products)
      order.remove_product("salad")
      expected_count = before_count - 1
      order.products.count.must_equal expected_count
    end

    it "It removes product from the collection of products" do
      products = { "banana" => 1.99, "cracker" => 3.00, "salad" => 4.25 }
      order = Grocery::Order.new(1337, products)
      order.remove_product("salad")
      order.products.include?("salad").must_equal false
    end

    it "Returns true if the product was present in collection and removed" do
      products = { "banana" => 1.99, "cracker" => 3.00 }
      order = Grocery::Order.new(1337, products)
      before_total = order.total
      result = order.remove_product("banana")
      after_total = order.total
      result.must_equal true
      before_total.wont_equal after_total
    end

    it "Returns false if the product is not already in product collection" do
      products = { "banana" => 1.99, "cracker" => 3.00 }
      order = Grocery::Order.new(1337, products)
      result = order.remove_product("salad")
      result.must_equal false
    end
  end # remove product

end # order wave 1

describe "Order Wave 2" do
  before do
    @orders = Grocery::Order.all
  end
  # id  is going to be an integer first index in array
  # second thing in the array is going to be a hash of products and prices
  # products are keys
  # prices are values
  describe "Order.all" do
    it "Returns an array of all orders" do
      @orders.must_be_kind_of Array
    end
    it "The number of orders is correct" do
      @orders.length.must_equal 100
      #count not length?
    end
    it "Everything in the array is an Order" do
      10.times do
        @orders[rand(100)].must_be_instance_of Grocery::Order
      end
    end
    it "The ID and products of the first and last" do
      orders_first = [1, {"Slivered Almonds" => 22.88, "Wholewheat flour" => 1.93, "Grape Seed Oil" => 74.9}]
      @orders.first.id.must_equal orders_first[0]
      @orders.first.products.must_equal orders_first[1]
      # must_be versus must_equal
    end

  end

  describe "Order.find" do
    #why doesn't this work???
    # before do
    #   @orders = Grocery::Order.find(id)
    # end
    it "Can find the first order from the CSV" do
      # should be able to put in an id and the order should output and match
      Grocery::Order.find(1).id.must_equal 1
      # && @orders.first.id
    end

    it "Can find the last order from the CSV" do
      Grocery::Order.find(100).id.must_equal 100
      # && @orders.last.id
    end


    it "Raises an error for an order that doesn't exist" do
      # all_orders = CSV.read("../support/orders.csv")
      error_order = (Grocery::Order.all.max_by{|o|o.id}).id + 1

      proc {Grocery::Order.find(101)}.must_raise ArgumentError
      proc {Grocery::Order.find(error_order)}.must_raise ArgumentError


    end
  end
end
