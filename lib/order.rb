require 'csv'
require 'awesome_print'

module Grocery
  class Order
    @@orders = []
    attr_reader :id, :products

    def initialize(id, products)
      @id = id
      @products = products
      @@orders << self
    end

    def self.all(csv_file)
      csv_orders = Array.new
      CSV.read(csv_file).each do |purchase_array|
        order_id = purchase_array[0].to_i
        products_list = purchase_array[1].split(";")
        products = {}
        products_list.each do |product|
          product_with_price = product.split(":")
          products[product_with_price[0]] = product_with_price[1].to_f
        end
        csv_orders << Grocery::Order.new(order_id, products)
      end
      return csv_orders
    end

    def self.find_id(csv_file, id)
      csv_orders = self.all(csv_file)
      csv_orders.each do |order|
        if order.id == id
          return order
        end
      end
      raise ArgumentError.new "This order doesn't exist"
    end

    def self.show_all_orders
      return @@orders
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

orders = Grocery::Order.all('./support/orders.csv')

p Grocery::Order.find_id('./support/orders.csv', 54)
#
# ap Grocery::Order.show_all_orders



# order = Grocery::Order.new(2314, {"banana" => 1.99, "cracker" => 3.00})
#
# order.add_product("salad", 4.25)
# p order.products
