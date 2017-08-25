# Create a Grocery module that contains an Order class and any future grocery store logic.

# Create an Order class which should have the following functionality:

#A new order should be created/initialized with:
#-an ID, read-only
#-a collection of products and their cost
#-zero products is permitted
#--you can assume that there is only one of each product

# A total method which will calculate the total cost of the order by:
#-summing up the products
#-adding a 7.5% tax
#-ensure the result is rounded to two decimal places
#-An add_product method which will take in two parameters, product name and price, and add the data to the product collection
#-It should return true if the item was successfully added and false if it was not

require 'csv'
require 'awesome_print'

module Grocery
  class Order
    attr_reader :id, :products

    def initialize(id, products)
      @id = id
      @products = products #a collection of products and their cost -> products = {product_name: cost}
    end

    def total
      #GOAL: implement total
      product_costs = @products.values

      total = 0
      product_costs.each do |cost|
        total += cost
      end

      #-adding a 7.5% tax & round two decimal places
      total = total + (total * 0.075).round(2)
      return total
    end

    def add_product(product_name, product_price)
      #GOAL: implement add_product
      new_product = {product_name => product_price}

      product_keys = @products.keys #get list of product_names in products hash to compare new product name to

      if product_keys.include?(product_name)
        return false
      else
        @products.merge!(new_product)
        return true
      end
    end

    # def remove_product(product_name)
    #   #Add a remove_product method to the Order class which will take in one parameter, a product name to
    #   #Remove the product from the collection
    #   #It should return true if the item was successfully remove and false if it was not
    #
    #   @products.delete(product_name)
    # end

    def self.all(file_pathway)
      # This class method will handle all of the fields from the CSV file used as input
      # To test, choose the data from the first line of the CSV file and ensure you can create a new instance of your Order using that data
      orders = CSV.read(file_pathway, converters: :numeric)

      all_orders = []
      orders.each do |row|
        id = row[0]
        items = row[1].split(';')
        #generates (for first row):
        #id, items = ["Slivered Almonds: 22.88", "Wholewheat flour:1.93", "Grape Seed Oil:74.9"]

        products = {} #products hash {product_name: product_price}

        items.each do |item|
          product_price = item.split(":")
          #generates:
          #id, items = [["Slivered Almonds", "22.88"], ["Wholewheat flour", "1.93"], ["Grape Seed Oil","74.9"]]
          product_name = product_price[0]
          price = product_price[1]
          products[product_name] = price.to_f
        end

        all_orders << Order.new(id, products)
        #test using puts "#{id} with products #{products}"
      end

      return all_orders
    end

    def self.find(id)
      #self.find(id) - returns an instance of Order (an element in the all_orders array) where the value of the id field in the CSV matches the passed parameter
      orders = Grocery::Order.all

      orders.each do |element|
        if element.id == id
          return element
        end
      end
      raise ArgumentError.new("ORDER ##{id} NOT FOUND!")
    end

  end#of_Order_class

  class Customer
    attr_reader :customer_id, :email_address, :delivery_address

    def initialize(customer_id, email_address, delivery_address)
      @customer_id = customer_id
      @email_address = email_address
      @delivery_address = delivery_address
    end

    def self.all(file_pathway)
      customers = CSV.read('/Users/janedrozo/Desktop/grocery-store/support/customers.csv')

      all_customers = []

      customers.each do |row|
        customer_id = row[0]
        email_address = row[1]

        #SHORTHAND for delivery_address:
        delivery_address = (row[2..5]).join(",")
        #LONGHAND for delivery_address:
        # delivery_address = "#{row[2]},#{row[3]},#{row[4]},#{row[5]}"

        all_customers << Customer.new(customer_id.to_f, email_address, delivery_address)
      end

      return all_customers
    end

    def self.find(customer_id)
      customers = Grocery::Customer.all

      customers.each do |customer_row_info|
        if element.customer_id == customer_id
          return customer_row_info
        end
      end
      raise ArgumentError.new("CUSTOMER ##{customer_id} NOT FOUND!")
    end
  end#of_Customer_class

end#of_module

#TEST ORDER
# ap Grocery::Order.all('/Users/janedrozo/Desktop/grocery-store/support/orders.csv')

#TEST CUSTOMER
ap Grocery::Customer.all('/Users/janedrozo/Desktop/grocery-store/support/customers.csv')
