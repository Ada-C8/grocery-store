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

      order.must_respond_to :food_and_price
      order.food_and_price.length.must_equal 0
    end
  end

  describe "#total" do
    it "Returns the total from the collection of products" do
      food_and_price = { "banana" => 1.99, "cracker" => 3.00 }
      order = Grocery::Order.new(1337, food_and_price)

      sum = food_and_price.values.inject(0, :+)
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
      order.food_and_price.count.must_equal expected_count
    end

    it "Is added to the collection of products" do
      products = { "banana" => 1.99, "cracker" => 3.00 }
      order = Grocery::Order.new(1337, products)

      order.add_product("sandwich", 4.25)
      order.food_and_price.include?("sandwich").must_equal true
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
        order.food_and_price.count.must_equal expected_count
      end

      it "Is deleted from the collection of products" do
        products = { "banana" => 1.99, "cracker" => 3.00 }
        order = Grocery::Order.new(1337, products)

        order.remove_product("cracker")
        order.food_and_price.include?("cracker").must_equal false
      end

      it "Returns true if the product is present" do
        products = { "banana" => 1.99, "cracker" => 3.00 }

        order = Grocery::Order.new(1337, products)
        num_of_items = order.food_and_price.keys.length

        result = order.remove_product("banana")
        after_num_of_items = order.food_and_price.keys.length

        result.must_equal true
        (num_of_items - 1).must_equal after_num_of_items
      end

      it "Returns false if the product is new" do
        products = { "banana" => 1.99, "cracker" => 3.00 }
        order = Grocery::Order.new(1337, products)

        result = order.remove_product("salad")
        result.must_equal false
      end


    end

  end

describe "Order Wave 2" do
  describe "Order.all" do
    it "Returns an array of all orders" do
    all_the_orders = Grocery::Order.all("./support/orders.csv")
    all_the_orders.must_be_instance_of Array
    all_the_orders.length.must_equal 100
    all_the_orders[0].id.must_equal 1
    all_the_orders[98].id.must_equal 99
    all_the_orders[1].food_and_price.must_equal({"Albacore Tuna"=>36.92, "Capers"=>97.99, "Sultanas"=>2.82, "Koshihikari rice"=>7.55 })
    all_the_orders[99].food_and_price.must_equal({"Allspice"=>64.74, "Bran"=>14.72, "UnbleachedFlour"=>80.59})
    end
  end

  describe "Order.find" do
    it "Can find the first order from the CSV" do
      order = Grocery::Order.find("./support/orders.csv", 1)
      order.id.must_equal 1
    end

    it "Can find the last order from the CSV" do
      order = Grocery::Order.find("./support/orders.csv", 100)
      order.id.must_equal 100

    end

    it "Raises an error for an order that doesn't exist" do
      proc {Grocery::Order.find("./support/orders.csv", 150)}.must_raise ArgumentError
    end
  end
end
