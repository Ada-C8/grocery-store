require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/order2'

describe "Order Wave 1" do
  describe "#initialize" do
    it "Takes an ID and collection of products" do
      id = 1337
      order = Grocery::Order.new(id, [])

      order.must_respond_to :id
      order.id.must_equal id
      order.id.must_be_kind_of Integer

      order.must_respond_to :products
      order.products.length.must_equal 0
    end
  end

  describe "#total" do
    it "Returns the total from the collection of products" do
      products = [{ "name" => "banana", "price" => 1.99, "quantity" => 6 }, { "name" => "sandwich", "price" => 4.99, "quantity" => 1 }]
      order = Grocery::Order.new(1337, products)

      sum = 0
      products.each do |hash|
        sum +=  (hash["price"] * hash["quantity"])
      end

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
      products = [{ "name" => "banana", "price" => 1.99, "quantity" => 6 }, { "name" => "sandwich", "price" => 4.99, "quantity" => 1 }]
      before_count = products.count
      order = Grocery::Order.new(1337, products)

      order.add_product({ "name" => "salad", "price" => 2.49, "quantity" => 2 })
      expected_count = before_count + 1
      order.products.count.must_equal expected_count
    end

    it "Is added to the collection of products" do
      products = [{ "name" => "banana", "price" => 1.99, "quantity" => 6 }, { "name" => "sandwich", "price" => 4.99, "quantity" => 1 }]
      products2 = products
      order = Grocery::Order.new(1337, products)

      order.add_product({ "name" => "salad", "price" => 2.49, "quantity" => 2 })

      # new_prod = false
      # order.products.each do |hash|
      #   if hash["name"] = "salad"
      #     new_prod = true
      #   end
      # end
      # new_prod.must_equal true

      products2 << {"name" => "salad", "price" => 2.49, "quantity" => 2 }

      products.must_equal products2

    end

    it "Updates the quantity of a product already present" do
      products = [{ "name" => "banana", "price" => 1.99, "quantity" => 6 }, { "name" => "sandwich", "price" => 4.99, "quantity" => 1 }]
      order = Grocery::Order.new(1337, products)

      order.add_product({ "name" => "banana", "price" => 1.99, "quantity" => 1 })

      order.products.each do |hash|
        if hash["name"] = "banana"
          hash["quantity"].must_equal 1
        end
      end
    end

  end


  xdescribe "#remove_product" do
    it "decreases the number of products" do
      products = [{ "name" => "banana", "price" => 1.99, "quantity" => 6 }, { "name" => "sandwich", "price" => 4.99, "quantity" => 1 }]
      before_count = products.count
      order = Grocery::Order.new(1337, products)

      order.remove_product("banana")
      expected_count = before_count - 1
      order.products.count.must_equal expected_count
    end

    it "Is removed to the collection of products" do
      products = { "banana" => 1.99, "cracker" => 3.00 }
      order = Grocery::Order.new(1337, products)

      order.remove_product("banana")
      order.products.include?("banana").must_equal false
    end

    it "Returns false if the product is not present" do
      products = { "banana" => 1.99, "cracker" => 3.00 }

      order = Grocery::Order.new(1337, products)
      before_total = order.total

      result = order.remove_product("orange")
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
xdescribe "Order Wave 2" do
  describe "Order.all" do
    it "Returns an array of all orders" do
      # TODO: Your test code here!
      # Useful checks might include:
      #   - Order.all returns an array
      #   - Everything in the array is an Order
      #   - The number of orders is correct
      #   - The ID and products of the first and last
      #       orders match what's in the CSV file
      # Feel free to split this into multiple tests if needed
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
