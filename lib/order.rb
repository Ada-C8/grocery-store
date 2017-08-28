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

    def self.all
      # This class method will handle all of the fields from the CSV file used as input
      # To test, choose the data from the first line of the CSV file and ensure you can create a new instance of your Order using that data
      orders = CSV.read('./support/orders.csv', converters: :numeric)

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

      orders.each do |order_instance|
        if order_instance.id == id
          return order_instance
        end
      end
      #if we go through the loop without finding a match, then we raise an error
      raise ArgumentError.new("ORDER ##{id} NOT FOUND!")
    end

  end#of_Order_class

end#of_module

#TEST ORDER
# ap Grocery::Order.all
