require 'csv'
require 'awesome_print'

module Grocery
  class Order
    attr_reader :id, :products

    def initialize(id, products)
      @id = id
      @products = products
    end

    def self.all(csv_file)
      @@orders = []
      CSV.read(csv_file).each do |purchase_array|
        order_id = purchase_array[0].to_i
        products_list = purchase_array[1].split(";")
        products_list.each do |product|
          products = {}
          product_with_price = product.split(":")
          products[product_with_price[0]] = product_with_price[1].to_i
          @@orders << Grocery::Order.new(order_id, products)
        end
      end
      return @@orders
    end

    def self.find_id(id)
    end

    def total
      sum = 0
      products.each do |product, price|
        sum += price
      end
      total = (sum + sum * 0.075).round(2)
      return total
    end

    def add_product(product_name, product_price)
      if @products.keys.include?(product_name)
        return false
      else
        @products[product_name] = product_price
        return true
      end
    end

    def remove_product(product_name)
      if @products.has_key?(product_name)
        @products.delete(product_name)
        return true
      else
        return false
      end
    end

  end
end

ap Grocery::Order.all('./support/orders.csv')
# order = Grocery::Order.new(2314, {"banana" => 1.99, "cracker" => 3.00})
#
# order.add_product("salad", 4.25)
# p order.products
