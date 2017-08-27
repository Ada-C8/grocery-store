#####################
# Planning
#The products should be added as a hash, where each hash is a key value pair with the name of the product as the key and the price of the product as the value.

#To add a new peroduct to the order you should allow the user to enter two arguments, one for the product name and one for the price of the item. Then in the add_product method you should format the user input into a hash that is added to the order.
#Maybe use the money gem to make sure all of our money is in the right format?

#To get the order total you should sum all the hash values and multiply it by the tax
#Should I have a list of object ID's and what they link to?


require 'csv'

module Grocery
  class Order
    attr_reader :id, :products
    def initialize(id, products)
      @id = id
      @products = products #hash of product names and their prices
    end #initialize

#total method will sum up the price for each product in the order and then add a 7.5% tax
#Having inject(0) sets the default return to 0 if there are no product prices to inject
    def total
      sum = @products.values.inject(0) { |a, b| a + b }
      total = (sum + (sum * 0.075)).round(2)
      return total
    end #total

#The add_product method will check if the product name is already listed as a key in the products has stored in @products. If it is then the method will return false and not add that product. If it isn't then the product and its price will be added as a key value pair to the @products hash.
    def add_product(product_name, product_price)
      if @products.has_key?(product_name)
        return false
      else @products[product_name] = product_price
        return true
      end #if/else
    end #add_product

#Works in a similar way to the add_product method, but instead it confirms that the product name is a key in the @products hash. If it is then the key/value pair for that product is deleted from @products. If if doesn't exsist in @products then
    def remove_product(product_name)
      if @products.key?(product_name) == false
        return false
      else
        @products.delete(product_name)
        return true
      end #if/else
    end #remove_product

    def self.all
      #method that will return an array of all the orders in the csv file
      #We need to interarate through the array data from the csv file a bit in oder to populate the @products hash with key value pairs of data from the csv file. To do this we split the data at ; to separate in to seprate product names and their price separated by a :, and then we split at : so be able to set the product name and proce as a key/value pair in @products
      #Storing all of the orders in the local variabel all_orders (an array) and then I will call self.all to access this array since self.all returns the all_orders array
      all_orders = []
      CSV.open("support/orders.csv", 'r').each do |line|
        id = line[0]
        order_products = {}
        products = line[1].split(';')

        products.each do |item_price|
          product_price = item_price.split(':')
          order_products[product_price[0]] = product_price[1].to_f
        end #.each

        products = order_products

        all_orders << Grocery::Order.new(id, products)
      end #open

      return all_orders
    end #all

#Add this method so that the same self.find method in Order and OnlineOrder can access differnt arrays! I will override this method in the OnlineOrder class to return @all_online_orders
    def self.return_csv_array
      return self.all
    end

    def self.find(id_to_test)
#self.find(id) - returns an instance of Order where the value of the id field in the CSV matches the passed parameter.

    # I chose not to do this because in a different situation where we loaded the orders in a differnt way it wouldn't work:
      # x = self.all
      # if id_to_test.to_i > x.length
      #   raise ArgumentError.new("Error: order #{id_to_test} does not exsist!")
      # else
      #   all_orders.each do |order|
      #     if order.id == id_to_test
      #       return order
      #     end
      #   end
      # end

#the code below accesses the all_orders array by calling the return_csv_array class method
#Then it checks to see if the order id exists in all_orders. If it does then the instance of Order with that id is returned. If it doesn't exsis then an error message is raised.
      if  return_csv_array.any?{|instance| instance.id == id_to_test.to_s}
            return_csv_array.each do |order|
              if order.id == id_to_test.to_s
                return order
              end #if
            end # .each
      else
        raise ArgumentError.new("Error: order #{id_to_test} does not exsist!")
      end # if/else

    end #self.find(id)

  end #Order class
end # Grocery module
