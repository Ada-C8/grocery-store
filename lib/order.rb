##### Qs: what is the purpose of the id?
# should there be an array of hashes to store what the store has already?
# should I initialize price (Why only id and products?)
# how to add to product list?

module Grocery
  class Order
    attr_reader :id, :products

    def initialize(id, products)
      @id = id
      @products = products
      # @count = count
    end # end of initialize
    # zero products is permitted
    # you can assume that there is only one of each product

    #  @products =
    #    { "banana" => 1.99,
    #      "cracker" => 3.00 }
    #

    def total
      # TODO: implement total
      # summing up the products
      # adding a 7.5% tax
      # ensure the result is rounded to two decimal places
      @products.each do |product, values|
        sum = @products.values.inject(0, :+)
        return (sum + (sum * 0.075).round(2))
      end # products loop
    end # total method

    def add_product(product_name, product_price)
      # TODO: implement add_product
      # add product to products collection
      # It should return true if the item was successfully added and false if it was not
      # @products << add_product(product_name, product_price)
        @products << @products["sandwich"] = 4.25
        # before_count = @products.length
        # @count = before_count + 1
    end # add product method
  end # Order class
end # Grocery module

test_order = Grocery::Order.new(1337, { "banana" => 1.99, "cracker" => 3.00, "treat" => 1.00 })
puts test_order.total
# test_order.add_product
puts test_order.products
 # puts @products.values
# test_order.add_product("banana", 4.25)
# puts test_order.add_product
