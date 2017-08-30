#MOVED CODE BELOW INTO SPEC_HELPER.RB !
# require 'minitest/autorun'
# require 'minitest/reporters'
# require 'minitest/skip_dsl'
# require_relative '../lib/order'
#
# Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

require_relative 'spec_helper'

describe "Order Wave 1" do
  describe "#initialize" do
    it "Takes an ID and collection of products" do
      id = 1337
      order = Grocery::Order.new(id, {})

      order.must_respond_to :id
      order.id.must_equal id
      order.id.must_be_kind_of Integer

      order.must_respond_to :products
      order.products.length.must_equal 0 #because the products hash is empty
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
      order.products.keys.include?("sandwich").must_equal true
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
  end # add_product

  describe "remove_product" do
    it "decreases the number of products" do
      products = { "banana" => 1.99, "cracker" => 3.00 }
      before_count = products.count
      order = Grocery::Order.new(1337, products)

      order.remove_product("banana")
      expected_count = before_count - 1
      order.products.count.must_equal expected_count
    end

    it "is removed from the collection of products" do
      products = { "banana" => 1.99, "cracker" => 3.00 }
      order = Grocery::Order.new(1337, products)

      order.remove_product("sandwich")
      order.products.keys.include?("sandwich").must_equal false
    end # it is removed from the collection

    it "will return true if the product is included in the product list" do
      products = { "banana" => 1.99, "cracker" => 3.00 }

      order = Grocery::Order.new(1337, products)
      before_total = order.total

      result = order.add_product("banana", 4.25)
      after_total = order.total

      result.wont_equal true
      before_total.must_equal after_total
    end #it "will return false if the product is not included in the product list" do

    it "will return false if the product is NOT included in the product list" do
      products = { "banana" => 1.99, "cracker" => 3.00 }

      order = Grocery::Order.new(1337, products)
      before_total = order.total

      result = order.add_product("banana", 4.25)
      after_total = order.total

      result.must_equal false
      before_total.must_equal after_total
    end #it "will return false if the product is not included in the product list" do
  end # remove_product
end

# TODO: change 'xdescribe' to 'describe' to run these tests
describe "Order Wave 2" do
  describe "Order.all" do
    # TODO: Your test code here!
    # Useful checks might include:
    #   - Order.all returns an array
    #   - Everything in the array is an Order
    #   - The number of orders is correct
    #   - The ID and products of the first and last
    #       orders match what's in the CSV file
    # Feel free to split this into multiple tests if needed
    it "Returns an array of all orders" do
      Grocery::Order.all.must_be_kind_of Array
    end # it "Returns an array of all orders" do

    it "will have erything in the Order.all array be an instsnce of the Order class" do
      test = Grocery::Order.all
      test.length.times do |i|
        test[i].must_be_kind_of Grocery::Order
      end
    end #it "will have erything....

    it "will contain the right numnber of orders" do
      all_orders = []
      CSV.open("support/orders.csv", 'r').each do |line|
        all_orders << Grocery::Order.new(line[0], line[1].split(";"))
      end

      Grocery::Order.all.length.must_equal all_orders.length
    end #it "will contain ....

    it "will have the right id for the first order" do
      first_order = CSV.open('support/orders.csv', 'r') { |csv| csv.first }
      test = Grocery::Order.all

      test[0].id.must_equal first_order[0][0]
    end #it "will have the right id for the first order

    it "will have the right product for the first order" do
      first_order = CSV.open('support/orders.csv', 'r') { |csv| csv.first }
      order_products = {}
      products = first_order[1].split(";")
      products.each do |item_price|
        product_then_price = item_price.split(":")
        order_products[product_then_price[0]] = product_then_price[1].to_f
      end
      test_hash = {first_order[0] => order_products}

      test = Grocery::Order.all

      test[0].products.must_equal test_hash[first_order[0]]
    end #it "will have the right product for the first order


    it "will have the right id for the last order" do
      #TODO is there a better way to do this that does't basically repeat the code in order.rb?
      all_orders = []
      CSV.open("support/orders.csv", 'r').each do |line|
        all_orders << Grocery::Order.new(line[0], line[1].split(";"))
      end

      test = Grocery::Order.all
      test[-1].id.must_equal all_orders[-1].id.to_s
    end #it "will have the right id for the last order

    it "will have the right products for the last order" do
      #TODO is there a better way to do this that does't basically repeat the code in order.rb?
      all_orders = []
      CSV.open("support/orders.csv", 'r').each do |line|
        id = line[0]

        order_products = {}
        products = line[1].split(';')

        products.each do |item_price|
          product_price = item_price.split(':')
          order_products[product_price[0]] = product_price[1].to_f
        end
        products = order_products
        all_orders << Grocery::Order.new(id, products)
      end

      test = Grocery::Order.all

      test[-1].products.must_equal all_orders[-1].products
    end #it "will have the right products for the last order
  end # discribe "Order.all" do

  describe "Order.find" do
    it "Can find the first order from the CSV" do
      # TODO: Your test code here!
      #self.find(id) - returns an instance of Order where the value of the id field in the CSV matches the passed parameter.
      first_order = CSV.open('support/orders.csv', 'r') { |csv| csv.first }
      order_products = {}
      products = first_order[1].split(";")
      products.each do |item_price|
        product_then_price = item_price.split(":")
        order_products[product_then_price[0]] = product_then_price[1].to_f
      end
      test_hash = {first_order[0] => order_products}

      Grocery::Order.all
      test = Grocery::Order.find(1)

      test.products.must_equal test_hash[first_order[0]]
    end # it "Can find the first order...

    it "Can find the last order from the CSV" do
      # TODO: Your test code here!

      all_orders = []
      CSV.open("support/orders.csv", 'r').each do |line|
        id = line[0]

        order_products = {}
        products_split = line[1].split(';')

        products_split.each do |item_price|
          product_price = item_price.split(':')
          order_products[product_price[0]] = product_price[1].to_f
        end
        products = order_products
        all_orders << Grocery::Order.new(id, products)
      end


      Grocery::Order.all
      test = Grocery::Order.find(all_orders.length)

      #Not producing the same list of products....
      test.products.must_equal all_orders[-1].products
    end


    it "must return only one order" do
      test_array = []
      Grocery::Order.all
      test = Grocery::Order.find("2")
      test_array << test.id
      test_array.length.must_equal 1
    end

    it "Raises an error for an order that doesn't exist" do
      # TODO: need to modify the add_product method to add the instance onto the all_orders array and then check all_orders.length + 1 here instead of yay_orders.length + 1
      yay_orders = CSV.read("support/orders.csv", 'r')

      Grocery::Order.all
      proc {Grocery::Order.find(yay_orders.length + 1)}.must_raise ArgumentError

    end
  end
end
