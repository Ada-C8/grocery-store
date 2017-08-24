require 'csv'

hash = {}

CSV.open("support/orders.csv", "r").each do |line|
   hash[line[0].to_i] = line[1]
 end

hash.each do |k, v|
  hash[k] = v.split(";")
end

hash.each do |k,v|
  product_hash = {}
  v.each do |string|
    order = string.split(":")
    product_hash[order[0]] = order[1].to_f
  end
  hash[k] = product_hash
end

module Grocery
  class Order
    attr_reader :id, :products

@@array = []

    def initialize(id, products)
      @id = id
      @products = {}

      if products.length > 0
        products.each {|product, value| @products[product] = value}
      end

      item_array = [@id, @products]
      @@array << item_array
    end

    def total
      sum = 0
      products.each_value do |value|
        sum = sum + value
      end
      expected_total = sum + (sum * 0.075).round(2)
      return expected_total
    end

    def add_product(product_name, product_price)
      unless @products.has_key?(product_name)
        @products[product_name] = product_price
        return true
      else
        return false
      end
    end

    def remove_product(product_name)
      if @products.has_key?(product_name)
        @products.delete(product_name)
      else
        return @products
      end

#class method
#returns a collection of order instances, representing all the orders
#in the CSV file

    def self.all
    end

#class method
    def self.find(id)
    end

    end

  end
end


array = []
hash[1].each_value do |product, value|
  array << [product] = value
end

puts array
