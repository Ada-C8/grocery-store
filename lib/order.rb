require 'csv'

module Grocery
  class Order
    attr_reader :id, :products

    def initialize(id, products)
      # products is a hash with product name as key, price as value
      @id = id
      @products = products
    end

    def total
      # implement total
      total = 0

      # iterate through products hash and add to total
      products.each_value do |product_price|
        total += product_price
      end

      # add 7.5% tax and round to 2 decimal places
      return (total * 1.075).round(2)
    end

    def add_product(product_name, product_price)
      # implement add_product

      # don't add product if already in @products
      if @products.include?(product_name)
        return false
      # else add to hash
      else
        @products[product_name] = product_price
        return true
      end
    end

    def remove_product(product_name)
      if @products.include?(product_name)
        @products.delete(product_name)
        return true
      else
        return false
      end
    end

    def self.all
      # returns a collection of all Orders from the csv
      #1,Slivered Almonds:22.88;Wholewheat flour:1.93;Grape Seed Oil:74.9

      csv = "./support/orders.csv"
      all_orders = []

      CSV.foreach(csv) do |row|
        id = row[0].to_i
        # get list of each product in form "name:price"
        product_info = row[1]
        products = parse_products(product_info)

        order = Order.new(id, products)
        all_orders << order
        # product_list.each do |product|
        #   # split into array of form ["name", price]
        #   product_info = product.split(":")
        #   product_name = product_info[0]
        #   product_price = product_info[1].to_f
        #   products[product_name] = product_price
        # end
      end

      return all_orders
    end

    def self.find(id)
      # returns order with given id if found; else returns nil
      all_orders = self.all

      # iterate through Orders, look for id
      all_orders.each do |order|
        if order.id == id
          return order
        end
      end

      # if order not found
      raise ArgumentError.new("No such order id")
    end

    private

    def self.parse_products(product_string)
      # helper method that parses a string in the form "prod_name:prod_price;prod_name:prod_price"
      # into a hash of products of form {prod_name => prod_price}
      products = {}

      product_list = product_string.split(";")

      product_list.each do |product|
        # split into array of form ["name", "price"]
        product_info = product.split(":")
        product_name = product_info[0]
        product_price = product_info[1].to_f

        products[product_name] = product_price
      end

      return products
    end
  end
end
