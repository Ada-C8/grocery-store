require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
# require 'csv'
require_relative '../lib/order'
# require_relative '/support/orders.csv'


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
    it "Decreases the number of products" do
      products = { "banana" => 1.99, "cracker" => 3.00 }
      before_count = products.count
      order = Grocery::Order.new(1337, products)

      order.remove_product("banana")
      expected_count = before_count - 1
      order.products.count.must_equal expected_count
    end

    it "Is removed from the collection of products" do
      products = { "banana" => 1.99, "cracker" => 3.00 }
      order = Grocery::Order.new(1337, products)

      order.remove_product("banana")
      order.products.include?("banana").must_equal false
    end

    it "Returns false if the product is not removed" do
      products = { "banana" => 1.99, "cracker" => 3.00 }

      order = Grocery::Order.new(1337, products)
      before_total = order.total

      result = order.remove_product("sandwich")
      after_total = order.total

      result.must_equal false
      before_total.must_equal after_total
    end

    it "Returns true if the product is removed" do
      products = { "banana" => 1.99, "cracker" => 3.00 }
      order = Grocery::Order.new(1337, products)

      result = order.remove_product("banana")
      result.must_equal true
    end
  end
end










# TODO: change 'xdescribe' to 'describe' to run these tests
describe "Order Wave 2" do
  describe "Order.all" do
    #   - Order.all returns an array
    it "Returns an array of all orders" do
      new_orders = Grocery::Order.all
      new_orders.must_be_kind_of Array
    end

    #   - Everything in the array is an Order in module Grocery
    it "Everything in the array is an Order" do
      new_orders = Grocery::Order.all
      new_orders[1].must_be_kind_of Grocery::Order
    end

    #   - The number of orders is correct
    # You could also hardcode the number of orders instead
    #of measureing the length of the csv file
    it "The number of orders is correct" do
      new_orders = Grocery::Order.all
      new_database = Grocery::Grocery_Records.new
      records = new_database.read_csv("support/orders.csv")
      new_orders.length.must_equal records.length
    end

    # I am not sure if this is a good way to do it.
    #pro: it does not use the exact same logic i used
    #for reading the csv file, so it might catch an error
    #con: I am not sure it is exactly testing that the
    # products match
    # it "The products must match the csv file" do
    #   new_orders = Grocery::Order.all
    #   index=0
    #   CSV.open("support/orders.csv", 'r').each do |line|
    #     line[1].delete(":").delete(";")
    #     new_orders[index].products.flatten.join("")
    #     index +=1
    #   end
    # end

    it "The first ids must match the first line of the csv" do
      new_orders = Grocery::Order.all
      csv = CSV.open("support/orders.csv", 'r')
      csv.to_a[0][0].must_equal new_orders[0].id
    end

    it "The last id must match the last csv line" do
      new_orders = Grocery::Order.all
      csv = CSV.open("support/orders.csv", 'r')
      csv.to_a[-1][0].must_equal new_orders[-1].id
    end

    it "The first product id must match the first csv line" do
      new_orders = Grocery::Order.all
      csv = CSV.open("support/orders.csv", 'r')
      csv_product = csv.to_a[0][1].delete(":").delete(";")
      order_product = new_orders[0].products.flatten.join("")
      order_product.must_equal csv_product
    end

    it "The last product id must match the last csv line" do
      new_orders = Grocery::Order.all
      csv = CSV.open("support/orders.csv", 'r')
      csv_product = csv.to_a[-1][1].delete(":").delete(";")
      order_product = new_orders[-1].products.flatten.join("")
      order_product.must_equal csv_product
    end


  end

  describe "Order.find" do
    it "Can find the first order from the CSV" do
      my_order = Grocery::Order.find(1)
      csv = CSV.open("support/orders.csv", 'r')
      csv.to_a[0][0].must_equal my_order.id
    end

    it "Can find the last order from the CSV" do
      my_order = Grocery::Order.find(100)
      csv = CSV.open("support/orders.csv", 'r')
      csv.to_a[99][0].must_equal my_order.id
    end

    it "Raises an error for an order that doesn't exist" do
      proc {Grocery::Order.find(1000)}.must_raise ArgumentError
    end
  end
end
