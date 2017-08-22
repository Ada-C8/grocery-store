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

module Grocery
  class Order
    attr_reader :id, :products

    def initialize(id, products)
      @id = id

      # if products.length <= 0
      #   raise ArgumentError.new("You must initialize with a product id and a collection of products") #ArgumentError means this argument is wrong
      # end

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
      product_keys = @products.keys

      if product_keys.include?(product_name)
        return false
      else
        @products.merge!(new_product)
        return true
    end

    def remove_product
      #Add a remove_product method to the Order class which will take in one parameter, a product name, and remove the product from the collection
      #It should return true if the item was successfully remove and false if it was not
    end
  end
end
end
