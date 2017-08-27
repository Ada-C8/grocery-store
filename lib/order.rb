require 'csv'

module Grocery

  class Order
    attr_reader :id, :products
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
          order[item[0]] = item[1].to_f
        end
        if @@csv == "../support/online_orders.csv"
          # status = row[3] customer = row[2]
          new = OnlineOrder.new(id, order, row[3].to_sym, row[2])
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
      if id > 0 && id <= all.length
        return all[id - 1]
      else
        raise ArgumentError.new("That order doesn't exist")
      end
    end

    def total
      if products.empty?
        return 0
      else
        sum = products.values.inject(0, :+)
        total = (sum + (sum * 0.075)).round(2)
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
