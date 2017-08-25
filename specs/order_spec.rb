require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/order'

# describe "Order Wave 1" do
#   describe "#initialize" do
#     it "Takes an ID and collection of products" do
#       id = 1337
#       order = Grocery::Order.new(id, {})
#
#       order.must_respond_to :id
#       order.id.must_equal id
#       order.id.must_be_kind_of Integer
#
#       order.must_respond_to :products
#       order.products.length.must_equal 0
#     end
#   end
#
#   describe "#total" do
#     it "Returns the total from the collection of products" do
#       products = { "banana" => 1.99, "cracker" => 3.00 }
#       order = Grocery::Order.new(1337, products)
#
#       sum = products.values.inject(0, :+)
#       expected_total = sum + (sum * 0.075).round(2)
#
#       order.total.must_equal expected_total
#     end
#
#     it "Returns a total of zero if there are no products" do
#       order = Grocery::Order.new(1337, {})
#
#       order.total.must_equal 0
#     end
#   end
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

describe "Order Wave 2" do
  describe "Order.all" do
    it "Returns an array of all orders" do  #order.all returns an array
      orders = Grocery::Order.all
      orders.must_be_kind_of Array
    end

    it "checks if orders match what is the CSV file" do
      orders = Grocery::Order.all
      csv = CSV.read("./support/orders.csv")
      csv_product = csv.to_a[18][1].gsub(/:|;/, " ")
      # csv_product.must_be_same_as "cats"
      order_product = orders[18].products.flatten.join(" ")
      order_product.must_equal csv_product
    end

    it "checks the number of orders is correct" do #check # of orders
      orders = Grocery::Order.all
      orders.length.must_equal 100
    end

    it "checks ID of the first order match what's in the CSV file" do
      orders = Grocery::Order.all
      # print orders
      csv = CSV.read("./support/orders.csv")
      csv_product = csv.to_a[0][0]
      csv_product.must_equal orders[0].id.to_i
    end

    it "checks ID of the last order match what's in the csv file" do
      orders = Grocery::Order.all
      csv = CSV.read("./support/orders.csv")
      csv_product = csv.to_a[-1][0]
      # print "#{csv_product} boo!"
      print "#{orders} hey!"
      csv_product.must_equal orders[-1]
    end

    it "checks product of the first order match what's in the csv file" do
      orders = Grocery::Order.all
      csv = CSV.read("./support/orders.csv")
      csv_product = csv.to_a[0][1].gsub(/:|;/, " ")
      order_product = orders[0].products.flatten.join(" ")
      csv_product.must_equal order_product
    end

    it "checks product of the last order match what's in the csv file" do
      orders = Grocery::Order.all
      csv = CSV.read("./support/orders.csv")
      csv_product = csv.to_a[-1][1].gsub(/:|;/, " ")
      order_product = orders[-1].products.flatten.join(" ")
      csv_product.must_equal order_product
    end

    it "checks everything in the array is an order" do
      orders = Grocery::Order.all
      orders.each do |order|
        order.must_be_instance_of Grocery::Order
      end
    end
  end

  describe "Order.find" do
    it "can find the first order from the CSV" do
      order = Grocery::Order.find(1)
      csv = CSV.read("./support/orders.csv")
      csv_order = csv.to_a[0]
      order.id.must_equal csv_order[0].to_i
    end

    it "Can find the last order from the CSV" do
      order = Grocery::Order.find(100)
      csv = CSV.read("./support/orders.csv")
      csv_order= csv.to_a[99]
      # print "#{csv_order} Hi"
      # print "#{order} Yo"
      order.id.must_equal csv_order[0].to_i
    end

    it "Raises an error for an order that doesn't exist" do
      # print Grocery::Order.find(101)
      proc {Grocery::Order.find(101)}.must_raise ArgumentError
      proc {Grocery::Order.find(200)}.must_raise ArgumentError
      proc {Grocery::Order.find(1000)}.must_raise ArgumentError
    end
  end
end
