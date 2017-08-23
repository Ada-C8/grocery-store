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

  describe "remove_product" do
    #checks if number of products is one less
    it "checks if removes product" do
      products = {"frozen pizza" => 6.50, "cat food" => 7.00, "tissues" => 3.25, "The Game by Neil Strauss" => 12.50, "Best Brand lotion" => 2.00, "laundry detergent" => 8.50}
      order = Grocery::Order.new(1337, products)
      before_count = products.count
      order.remove_product("laundry detergent")
      expected_count = before_count - 1
      order.products.count.must_equal expected_count
    end
    it "removes the correct item"
    it "checks if removes product" do
      products = {"frozen pizza" => 6.50, "cat food" => 7.00, "tissues" => 3.25, "The Game by Neil Strauss" => 12.50, "Best Brand lotion" => 2.00, "laundry detergent" => 8.50}
      order = Grocery::Order.new(1337, products)
      order.remove_product("laundry detergent")
      order.products.keys.wont_include("laundry detergent")
    end
  end
end

# TODO: change 'xdescribe' to 'describe' to run these tests
# xdescribe "Order Wave 2" do
#   xdescribe "Order.all" do
#     it "Returns an array of all orders" do
#       # TODO: Your test code here!
#       # Useful checks might include:
#       #   - Order.all returns an array
#       (Grocery::Order.all).must_be_instance_of Array
#       #   - Everything in the array is an Order
#       Grocery::Order.all.each must_be_instance_of Order
#       #   - The number of orders is correct
#       order1 = Grocery::Order.new(1337, {"frozen pizza" => 6.50, "cat food" => 7.00, "tissues" => 3.25, "The Game by Neil Strauss" => 12.50, "Best Brand lotion" => 2.00, "laundry detergent" => 8.50})
#       order2 = Grocery::Order.new(3445, {"artisinal loaf" => 5.00, "peppered salami" => 4.25, "sheepsmilk gouda cheese" => 6.25, "cosmopolitan magazine" => 4.30, "grapes" => 4.67, "Cupcake Chardonnay" => 6.00})
#       order3 = Grocery::Order.new(9203, {"National Enquirer" => 3.00, "Spaghetti in a can" => 0.50, "taco mix" => 1.25, "ground beast" => 7.34, "rice" => 2.00})
#       #   - The ID and products of the first and last
#       #       orders match what's in the CSV file
#       # Feel free to split this into multiple tests if needed
#     end
#   end
#
#   xdescribe "Order.find" do
#     it "Can find the first order from the CSV" do
#       # TODO: Your test code here!
#     end
#
#     it "Can find the last order from the CSV" do
#       # TODO: Your test code here!
#     end
#
#     it "Raises an error for an order that doesn't exist" do
#       # TODO: Your test code here!
#     end
#   end
# end
