require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/order'

xdescribe "Order Wave 1" do
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

      order.remove_product("cracker")
      expected_count = before_count - 1
      order.products.count.must_equal expected_count
    end

    it "Is removed from the collection of products" do
      products = { "banana" => 1.99, "cracker" => 3.00 }
      order = Grocery::Order.new(1337, products)

      order.remove_product("cracker")
      order.products.include?("cracker").must_equal false
    end

    it "Returns false if the product was not removed" do
      products = { "banana" => 1.99, "cracker" => 3.00 }

      order = Grocery::Order.new(1337, products)
      before_total = order.total

      result = order.remove_product("salad")
      after_total = order.total

      result.must_equal false
      before_total.must_equal after_total
    end

    it "Returns true if the product was successfully removed" do
      products = { "banana" => 1.99, "cracker" => 3.00 }
      order = Grocery::Order.new(1337, products)

      result = order.remove_product("cracker")
      result.must_equal true
    end
  end
end

# TODO: change 'xdescribe' to 'describe' to run these tests
describe "Order Wave 2" do
  describe "Order.all" do
    # TODO responds to all med
    it "responds to all method" do
      products = { "banana" => 1.99, "cracker" => 3.00 }
      my_order = Grocery::Order.new(1337, products)
      my_order.class.must_respond_to :all
    end
    it "Everything in the array is an order" do
      products = { "banana" => 1.99, "cracker" => 3.00 }
      my_order = Grocery::Order.new(1337, products)
      result = my_order.class.all
      result[0].must_be_instance_of Grocery::Order
    end
    it "The number of orders is correct" do
      products = { "banana" => 1.99, "cracker" => 3.00 }
      my_order = Grocery::Order.new(1337, products)
      result = my_order.class.all
      result.length.must_equal 100
    end
    it "The ID and product of the first and last orders match CSV" do
      products = { "banana" => 1.99, "cracker" => 3.00 }
      my_order = Grocery::Order.new(1337, products)
      result = my_order.class.all
      result[0].id.must_equal "1"
      result[-1].id.must_equal "100"
      #result[0].products.must_equal
      # ["1","Slivered Almonds:22.88;Wholewheat flour:1.93;Grape Seed Oil:74.9"]
      # result[-1].must_equal ["100","Allspice:64.74;Bran:14.72;UnbleachedFlour:80.59"]
    end
    end
  end

  xdescribe "Order.find" do
    it "Can find the first order from the CSV" do
      result = Order.find("1")
      result.id.must_equal "1"
      expected_products = {"Slivered Almonds"=>"22.88", "Wholewheat flour"=>"1.93", "Grape Seed Oil"=>"74.9"}
      result.product.must_equal expected_products
    end

    it "Can find the last order from the CSV" do
      result = Order.find("100")
      result.id.must_equal "100"
      expected_products = {"Allspice"=>"64.74", "Bran"=>"14.72", "Unbleached Flour"=>"80.59"}
      result.product.must_equal expected_products
    end

    it "Raises an error for an order that doesn't exist" do
      proc {Order.find("85783")}.must_raise ArgumentError
    end
  end
