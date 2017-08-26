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
    end #it for takes an id
  end #for initialize


  describe "#total" do
    it "Returns the total from the collection of products" do
      products = { "banana" => 1.99, "cracker" => 3.00 }
      order = Grocery::Order.new(1337, products)

      sum = products.values.inject(0, :+)
      expected_total = sum + (sum * 0.075).round(2)

      order.total.must_equal expected_total
    end #for returns total from collection


    it "Returns a total of zero if there are no products" do
      order = Grocery::Order.new(1337, {})
      order.total.must_equal 0
    end #returns zero
  end #for #total

  #
  describe "#add_product" do
    it "Increases the number of products" do
      products = { "banana" => 1.99, "cracker" => 3.00 }
      before_count = products.count
      order = Grocery::Order.new(1337, products)

      order.add_product("salad", 4.25)
      expected_count = before_count + 1
      order.products.count.must_equal expected_count
    end #increases the number of products

    it "Is added to the collection of products" do
      products = { "banana" => 1.99, "cracker" => 3.00 }
      order = Grocery::Order.new(1337, products)

      order.add_product("sandwich", 4.25)
      order.products.include?("sandwich").must_equal true
    end #added to the collection of products


    it "Returns false if the product is already present" do
      products = { "banana" => 1.99, "cracker" => 3.00 }

      order = Grocery::Order.new(1337, products)
      before_total = order.total

      result = order.add_product("banana", 4.25)
      after_total = order.total

      result.must_equal false
      before_total.must_equal after_total
    end #returns false if present

    it "Returns true if the product is new" do
      products = { "banana" => 1.99, "cracker" => 3.00 }
      order = Grocery::Order.new(1337, products)

      result = order.add_product("salad", 4.25)
      result.must_equal true
    end #returns true if present
  end #add_product methods

  describe "#remove_product" do

    it "Decreases the number of products" do
      products = { "banana" => 1.99, "cracker" => 3.00, "salad" => 4.25 }
      before_count = products.count
      order = Grocery::Order.new(1337, products)
      order.remove_product("salad")
      expected_count = before_count - 1
      order.products.count.must_equal expected_count
    end #decreases the number of products

    it "Returns true if the item was successfully removed." do
      products = { "banana" => 1.99, "cracker" => 3.00, "salad" => 4.25 }
      order = Grocery::Order.new(1337, products)
      result = order.remove_product("salad")
      result.must_equal true
    end #true if removed

    it "Returns false if the item was not removed." do
      products = { "banana" => 1.99, "cracker" => 3.00, "salad" => 4.25 }
      order = Grocery::Order.new(1337, products)
      order.remove_product("salad")
      order.products.keys.include?("salad").must_equal false
    end #false if not remove

  end #remove_product tests
end #for Wave One


describe "Order Wave 2" do

  describe "Order.all" do

    it "The number of orders is correct" do
      Grocery::Order.all.length.must_equal 100
    end # number is correct

    it "Returns an array of all orders" do
      order = Grocery::Order.all
      order.must_be_kind_of Array
    end #returns array

    it "Everything in the array is an order " do
      order = Grocery::Order.all
      order.each do |item|
         item.must_be_instance_of Grocery::Order
      end #order each do
    end #everything is an order

    it "The ID and products of the first and last orders match whats in the CSV file" do

      order = Grocery::Order.all
      order[0].id.must_equal 1
      order[99].id.must_equal 100

      order[0].products.include?("Slivered Almonds").must_equal true
      order[0].products.include?("Wholewheat flour").must_equal true
      order[0].products.include?("Grape Seed Oil").must_equal true

      order[99].products.include?("Allspice").must_equal true
      order[99].products.include?("Bran").must_equal true
      order[99].products.include?("UnbleachedFlour").must_equal true

    #  1,Slivered Almonds:22.88;Wholewheat flour:1.93;Grape Seed Oil:74.9
      # 0,Spring Onions:32.07;Vinegar:10.51;Nectarines:12.58;Mung Beans:27.41
      # 100,Allspice:64.74;Bran:14.72;UnbleachedFlour:80.59


    end #ID/products match
  end #order all


  describe "Order.find" do
    it "Can find the first order from the CSV" do
      x = Grocery::Order.find(1)
      x.products.include?("Slivered Almonds").must_equal true
      x.products.include?("Wholewheat flour").must_equal true
      x.products.include?("Grape Seed Oil").must_equal true
    end #can find the first order

    it "Can find the last order from the CSV" do
      x = Grocery::Order.find(100)
      x.products.include?("Allspice").must_equal true
      x.products.include?("Bran").must_equal true
      x.products.include?("UnbleachedFlour").must_equal true
    end #can find the last order

    it "Raises an error for an order that doesn't exist" do
      proc {Grocery::Order.find(110)}.must_raise ArgumentError
            # proc {Card.new(0, :diamonds)}.must_raise ArgumentError

    end #raises an error
  end #end Order.find
end #Order Wave Two
