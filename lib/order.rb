require 'csv'

# orders = []
# CSV.open("../support/orders.csv", "r").each do |row|
#     orders << row
# end
#
# p orders[3][1..-1]

module Grocery

  class Order
    attr_reader :id, :products

    def initialize(id, products)
      @id = id
      @products = products
    end

    def self.all
      all = []
      orders = {}
      CSV.open("../support/orders.csv", "r", converters: :numeric).each do |row|
        id = row[0] #id
        products = row[1].split(";") # will be hash ["a:b", "c:d", "e:f"]
        order = {}
        products.each do |item|
          item = item.split(":") # [a, b]
          order[item[0]] = item[1]
          # order = {a:b, c:d, etc}
          orders[id] = order
        end
      end
      all << orders

      all_instances = []
      all[0].each do |key, value|
        order_instance = Order.new(key,value)
        all_instances << order_instance
      end

      return all_instances
    end

    def self.find(id)
      all
      if id > 0 && id < 101
        return all[id - 1]
      else
        return "Sorry, that order doesn't exist"
      end
    end

    def total
      if products.length == 0
        total = 0
        return total
      else
        sum = products.values.inject(0, :+)
        total = sum + (sum * 0.075).round(2)
        return total
      end
    end

    def add_product(product_name, product_price)
      if @products.include? product_name
        return false
      else
        @products.merge!(product_name => product_price)
        return true
      end
    end

    def remove_product(product_name)
      if @products.include? product_name
        @products.delete(product_name)
        return true
      else
        return false
      end
    end

  end
end
