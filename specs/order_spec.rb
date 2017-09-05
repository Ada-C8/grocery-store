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
    it "Decreases the number of products by one" do
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
  end
end

describe "Order Wave 2" do
  describe "Order.all" do
    it "Returns an array of all orders" do
      Grocery::Order.all.must_be_kind_of Array
    end

    it "Everything in the array is an order" do
      Grocery::Order.all.each do |order|
        order.must_be_instance_of Grocery::Order
      end
    end

    it "The number of orders are correct" do
      Grocery::Order.all.count.must_equal 100
    end

    it "The products of each order must be a hash" do
      Grocery::Order.all.each do |order|
        order.products.must_be_kind_of Hash
      end
    end

    it "The id of each order must be an Integer" do
      Grocery::Order.all.each do |order|
        order.id.must_be_kind_of Integer
      end
    end

    # FIND A WAY TO MAKE THIS MORE DYANAMIC
    it "The ID and products of the first order match CSV file" do
      all_products = {"Slivered Almonds"=>22.88, "Wholewheat flour"=>1.93, "Grape Seed Oil"=>74.9}
      Grocery::Order.all.first.id.must_equal 1
      Grocery::Order.all.first.products.must_equal all_products
    end
    # FIND A WAY TO MAKE THIS MORE DYANAMIC
    it "The ID and products of the last order match CSV file" do
      all_products = { "Allspice" => 64.74, "Bran" => 14.72, "UnbleachedFlour" => 80.59 }
      Grocery::Order.all.last.id.must_equal 100
      Grocery::Order.all.last.products.must_equal all_products
    end
  end # DESCRIBE

  describe "Order.find" do
    it "Can find the first order from self.all orders" do
      # RETURNS AN INSTANCE OF ORDER BACK TO THE USER
      Grocery::Order.find(1).must_be_instance_of Grocery::Order
    end


    it "Can find the last order from self.all orders" do
      # Grocery::Order.all
      Grocery::Order.find(100).must_be_instance_of Grocery::Order
    end

    it "Raises an error for an order that doesn't exist" do
      # Grocery::Order.all
      proc {Grocery::Order.find(150)}.must_raise ArgumentError
    end
  end
end
