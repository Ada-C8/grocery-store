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
#   #
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
# #
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
# #
#     it "Is added to the collection of products" do
#       products = { "banana" => 1.99, "cracker" => 3.00 }
#       order = Grocery::Order.new(1337, products)
#
#       order.add_product("sandwich", 4.25)
#       order.products.include?("sandwich").must_equal true
#     end
# #
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
#   end
#     it "Returns true if the product is new" do
#       products = { "banana" => 1.99, "cracker" => 3.00 }
#       order = Grocery::Order.new(1337, products)
#
#       result = order.add_product("salad", 4.25)
#       result.must_equal true
#     end
#   end
# end

# # TODO: change 'xdescribe' to 'describe' to run these tests
describe "Order Wave 2" do
  describe "Order.all" do
    it "Returns an array of all orders" do
      order = Grocery::Order.all
      order.must_be_kind_of Array
    end
    #     * checks the output of the array (should it be in this file.)
    #* can be explicit based on the data
    #*can compare to # of 100
    #*check data was loaded correctly
    #can assume that csv is working
    #first[1] be explicit and reference 100[1]
    #     it "Check everything in the array is an order" do
    #     end
    #     check there are no strings or characters etc
    #
    it "checks the number of orders is correct" do
      order = Grocery::Order.all
      order.length.must_equal 100
    end

    it "checks ID the first and last order match what's in the CSV file" do
      order = Grocery::Order.all
      csv = CSV.open("./support/orders.csv", 'r')
      csv.to_a[0][0].must_equal order[0].id
    end

    it "checks ID of the last order match what's in the csv file" do
      order = Grocery::Order.all
      csv = CSV.open("./support/orders.csv", 'r')
      csv.to_a[-1][0].must_equal order[-1].id
    end

    it "checks product of the first order match what's in the csv file" do
      order = Grocery::Order.all
      csv = CSV.open("./support/orders.csv", 'r')
      csv_product = csv.to_a[0][1].delete(":").delete(";")
      order_product = order[0].products.flatten.join
      csv_product == order_product
    end
    # it "checks everything in the array is an order" do
    #   order = Grocery::Order.all
    #
    #     order.products
    #     products
    # end
  end
end


#       compare the output of array to the line[1] and line[-1] from csv file
  # end
      # TODO: Your test code here!
      # Useful checks might include:
      #   - Order.all returns an array
      #   - Everything in the array is an Order
      #   - The number of orders is correct
      #   - The ID and products of the first and last
      #       orders match what's in the CSV file
      # Feel free to split this into multiple tests if needed
    # end
# end
# #
# #   describe "Order.find" do
# #     it "Can find the first order from the CSV" do
# #       # TODO: Your test code here!
# #     end
# #
# #     it "Can find the last order from the CSV" do
# #       # TODO: Your test code here!
# #     end
# #
# #     it "Raises an error for an order that doesn't exist" do
# #       # TODO: Your test code here!
# #     end
# #   end
# end
