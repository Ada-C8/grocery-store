#####################
# Planning
    #The products should be added as a hash, where each hash is a key value pair with the name of the product as the key and the price of the product as the value.

    #To add a new peroduct to the order you should allow the user to enter two arguments, one for the product name and one for the price of the item. Then in the add_product method you should format the user input into a hash that is added to the order.
      #Maybe use the money gem to make sure all of our money is in the right format?

    #To get the order total you should sum all the hash values and multiply it by the tax
    #Should I have a list of object ID's and what they link to?



module Grocery
  class Order
    attr_reader :id, :products

#Need to allow 0 product to be entered
    def initialize(id, products)
      @id = id
      @products = products
    end #initialize

    def total
      sum = @products.values.inject(0) { |a, b| a + b }
      total = (sum + (sum * 0.075)).round(2)
      return total
    end #total

    def add_product(product_name, product_price)
      # TODO: implement add_product
      product_name = product_name.to_sym
      if @products.keys.include?(product_name)
        return false
      else @products[product_name] = product_price
        return true
      end #if/else

    end #add_product
  end #Order class
end # Grocery module


test_order = Grocery::Order.new(123, {apple: 3, pear: 2})
test_total_before = test_order.total
test_add = test_order.add_product("rice", 2)
test_total = test_order.total

puts test_add
puts "*********"
puts test_total

items = test_order.products
items.keys.include?(:rice)
