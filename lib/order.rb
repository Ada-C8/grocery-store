require 'csv'
require 'awesome_print'

#remember: add product and add order are two completely different things!

module Grocery
  class Order
    attr_reader :id, :products
    def initialize(id, products) #takes in products as an array of hashes
      @id = id
      @products = products
    end

    def total
      @sum = @products.values.inject(0, :+)
      @total = @sum + (@sum * 0.075).round(2)
    end

    def add_product(product_name, product_price)
      if @products.include?(product_name)
        return false
      else
        @products[product_name] = product_price
        return true #Why do we want to return true here?
      end
    end

    def remove_product(product_name)
      unless @products.include?(product_name)
        return false
      end
      @products.delete(product_name)
      return true
    end

    def self.all
      all_orders = []
      CSV.open("/Users/galeharrington/ada/week3/grocery-store/support/orders.csv", 'r').each do |line|
        products_array = []
        id = line.slice!(0).to_i
        line.join.split(";").each do |product| #Eliminate "outer" array. Split resulting string into array of products.
          product_hash = {}
          product_hash[product.split(":")[0]] = product.split(":")[1].to_f #create key, value pair for name, price of product
          products_array << product_hash
        end
        all_orders << Grocery::Order.new(id, products_array)
      end
      return all_orders
    end

    def self.find(id)
      if id.to_i < 1 || id.to_i > 100
        return "This order does not exist."
      end
      return self.all[id - 1]
    end

  end
end

ap Grocery::Order.all
