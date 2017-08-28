require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require 'csv'
require_relative '../lib/order.rb'


describe "Order Wave 1" do
  describe "#initialize" do
    it "Takes an ID and collection of products" do
      id = 1337
      products = ""
      order = Grocery::Order.new(id, products)

      order.must_respond_to :id
      order.id.must_equal id
      order.must_respond_to :products
      order.products.length.must_equal 0
    end
  end

  describe "#total" do
    it "Returns the total from the collection of products" do
      products = "banana:1.99;cracker:3.00"
      order = Grocery::Order.new(1337, products)
      products_pairs = products.split(";")
      div_products_pairs = {}
      products_pairs.each do |pair|
        prod_price = pair.split(":")
        div_products_pairs[prod_price[0]] = prod_price[1].to_f
      end

      sum = 0

      div_products_pairs.each do |product, price|
          sum += price
      end



      sum = sum + (sum * 7.5/100).round(2)

      order.total.must_equal sum
    end

    it "Returns a total of zero if there are no products" do
      order = Grocery::Order.new(1337, "")
      order.total.must_equal 0
    end
  end

  describe "#add_product" do
    it "Increases the number of products" do
      products = "banana:1.99;cracker:3.00"
      before_count = products.split(";").count
      order = Grocery::Order.new(1337, products)

      order.add_product("salad",4.25)
      expected_count = before_count + 1
      order.products.count.must_equal expected_count
    end

    it "Is added to the collection of products" do
      products = "banana:1.99;cracker:3.00"
      order = Grocery::Order.new(1337, products)

      order.add_product("sandwich", 4.25)
      order.products.include?("sandwich").must_equal true
    end

    it "Returns false if the product is already present" do
      products = "banana:1.99;cracker:3.00"

      order = Grocery::Order.new(1337, products)
      before_total = order.total

      result = order.add_product("banana", 4.25)
      after_total = order.total

      result.must_equal false
      before_total.must_equal after_total
    end

    it "Returns true if the product is new" do
      products = "banana:1.99;cracker:3.00"
      order = Grocery::Order.new(1337, products)

      result = order.add_product("salad", 4.25)
      result.must_equal true
    end
  end


  describe "#remove_product" do
    it "decreases the number of products" do
      products = "banana:1.99;cracker:3.00"
      before_count = products.split(";").count
      order = Grocery::Order.new(1337, products)

      order.remove_product("banana")
      expected_count = before_count - 1
      order.products.count.must_equal expected_count
    end

    it "Is removed to the collection of products" do
      products = "banana:1.99;cracker:3.00"
      order = Grocery::Order.new(1337, products)

      order.remove_product("banana")
      order.products.include?("banana").must_equal false
    end

    it "Returns false if the product is not present" do
      products = "banana:1.99;cracker:3.00"

      order = Grocery::Order.new(1337, products)
      before_total = order.total

      result = order.remove_product("orange")
      after_total = order.total

      result.must_equal false
      before_total.must_equal after_total
    end

    it "Returns true if the product is removed" do
      products = "banana:1.99;cracker:3.00"
      order = Grocery::Order.new(1337, products)

      result = order.remove_product("banana")
      result.must_equal true
    end
  end
end

# TODO: change 'xdescribe' to 'describe' to run these tests
describe "Order Wave 2" do

  # before do
  #   products = { "banana" => 1.99; "cracker" => 3.00 }
  #   order = Grocery::Order.new(1337, products)
  # end

  describe "Order.all" do

    it "Returns an array of all orders" do
      Grocery::Order.all.must_be_kind_of Array
    end
  end

    # TODO: Your test code here!
  describe "Order.find" do

    it "Can find the first order from the CSV" do
      myorders = []
      CSV.read("./support/orders.csv").each do |row|
        myorders << Grocery::Order.new(row[0], row[1])
      end
      Grocery::Order.find("1").must_be_instance_of Grocery::Order
      Grocery::Order.find("1").id.must_equal myorders[0].id
    end

    it "Can find the last order from the CSV" do
      myorders = []
      CSV.read("./support/orders.csv").each do |row|
        myorders << Grocery::Order.new(row[0], row[1])
      end
      Grocery::Order.find("100").must_be_instance_of Grocery::Order
      Grocery::Order.find("100").id.must_equal myorders[99].id
    end

    it "Raises an error for an order that doesn't exist" do
      proc {Grocery::Order.find("101")}.must_raise ArgumentError
    end
  end
end
