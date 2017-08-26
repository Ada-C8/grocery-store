require 'csv'

module Grocery

  class Order
    attr_reader :id, :products
    attr_accessor :customer, :status
    @@csv = "../support/orders.csv"

    def initialize(id, products)
      @id = id
      @products = products
    end

    def self.all
      all_instances = []
      CSV.open(@@csv, "r", converters: :numeric).each do |row|
        id = row[0]
        products = row[1].split(";")
        order = {}
        products.each do |item|
          item = item.split(":")
          order[item[0]] = item[1]
        end
        if @@csv == "../support/online_orders.csv"
          new = Order.new(id, order)
          new.customer = row[2]
          new.status = row[3]
          all_instances << new
        else
          new = Order.new(id, order)
          all_instances << new
        end
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
        puts "I want to be fixed"
        # sum = products.(values).inject(0, :+)
        # total = sum + (sum * 0.075).round(2)
        total = "MaGiCaL"
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

# p Grocery::Order.all[3].total
p "I'm an Order"
p Grocery::Order.find(30)
puts "\n"
