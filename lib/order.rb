require 'csv'
require 'awesome_print'

module Grocery
  class Order
    attr_reader :id, :products
    def initialize(id, products) #products has to be a hash
      @id = id
      @products = products
    end

    def total
      @sum = 0
        @products.each_value do |value|
          @sum += value
        end
      @total = @sum + (@sum * 0.075).round(2)
    end

    def add_product(product_name, product_price)
      if @products.key?(product_name)
        return false
      else
        @products[product_name] = product_price
        return true
      end
    end

    def remove_product(product_name)
      unless @products.key?(product_name)
        return false
      end
      @products.delete(product_name)
      return true
    end

    def self.all
      all_orders = []
      CSV.open("/Users/galeharrington/ada/week3/grocery-store/support/orders.csv", 'r').each do |line|
        products_hash = {}
        id = line.slice!(0).to_i
        line.join.split(";").each do |product| #Eliminate "outer" array. Split resulting string into array of products.
          products_hash[product.split(":")[0]] = product.split(":")[1].to_f #create key, value pair for name, price of product
        end
        all_orders << Grocery::Order.new(id, products_hash)
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
