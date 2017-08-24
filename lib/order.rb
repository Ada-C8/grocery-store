#####################
# Planning
#The products should be added as a hash, where each hash is a key value pair with the name of the product as the key and the price of the product as the value.

#To add a new peroduct to the order you should allow the user to enter two arguments, one for the product name and one for the price of the item. Then in the add_product method you should format the user input into a hash that is added to the order.
#Maybe use the money gem to make sure all of our money is in the right format?

#To get the order total you should sum all the hash values and multiply it by the tax
#Should I have a list of object ID's and what they link to?



#Changed self.all method to create a hash for the product, so I think this broke some of my tests, because I wasn't treating @products as a hash in those tests
require 'csv'

module Grocery
  class Order
    attr_reader :id, :products
    #Need to allow 0 product to be entered
    #if I make this a class variable then the 'it "will contain the right numnber of orders"' test doesn't pass (it shows too many orders). Hoever, I am really not sure what kind variable to make @@all_orders so that I can both access the variable in the self.find method, and it won't be modified when I don't want it to be. Right now I am getting around this by resetting @@all_orders to and empty array every time self.all is run.

    @@all_orders = []

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
      if @products.has_key?(product_name)
        return false
      else @products[product_name] = product_price
        return true
      end #if/else
    end #add_product

    def remove_product(product_name)
      if @products.key?(product_name) == false
        return false
      else
        @products.delete(product_name)
        return true
      end #if/else
    end #remove_product

    def self.all
      #method that will return an array of all the orders
      #the numnber of orders in the array is correct,
      @@all_orders = []
      CSV.open("support/orders.csv", 'r').each do |line|
        id = line[0]
        order_products = {}
        products = line[1].split(';')

        products.each do |item_price|
          product_price = item_price.split(':')
          order_products[product_price[0]] = product_price[1].to_f
        end #.each

        products = order_products
        @@all_orders << Grocery::Order.new(id, products)
      end #open

      return @@all_orders
    end #all

    def self.find(id_to_test)
      #self.find(id) - returns an instance of Order where the value of the id field in the CSV matches the passed parameter.
      # TODO NEED TO MAKE THIS WORK
      x = self.all
      if id_to_test > x.length
        raise ArgumentError.new("Error: order #{id_to_test} does not exsist!")
      else
        @@all_orders.each do |order|
          if order.id == id_to_test
            return order
          end
        end 
        end

        # TODO GET THE ORDER RETURNED IF IT EXISTS AND RETURN FALSE IF IT DOESN'T EXIST:
        # if  @@all_orders.any?{|a| a.id == id_to_test}
        #       @@all_orders.each do |order|
        #         if order.id == id_to_test
        #           return order
        #         end
        #       end
        # else
        #   return false
        # end


        #code below is from before adding if statement to throw error
        # @@all_orders.each do |order|
        #   if order.id == id_to_test
        #     return order
        #   end
        # end
      end #self.find(id)

    end #Order class
  end # Grocery module

  #  Grocery::Order.all
  # test = Grocery::Order.find("2")
  #
  # puts test
  #  #=> true







  # test_order = Grocery::Order.new(123, {"apple" =>  3, "pear" => 2})
  # list_before = test_order.products
  # puts list_before
  # test_order.remove_product("apple")
  # list_after = test_order.products
  # puts list_after
