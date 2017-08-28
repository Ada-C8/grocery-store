require "csv"

module Grocery
  class Order
    attr_reader :id, :products

    def initialize(id, products)
      @id = id
      @products = products
    end

    def total
      # returns order total with tax
      sum = products.values.inject(0, :+)
      total = (sum + (sum * 0.075)).round(2)
      return total
    end

    def add_product(product_name, product_price)
      #  adds a product if product doesn't exist
      if @products.has_key?(product_name)
        return false
      else
        @products[product_name] = product_price
        return true
      end
    end

    def remove_product(product_name)
      # deletes product if the product is in the order
      if @products.has_key?(product_name)
        @products.delete(product_name)
        return true
      else
        return false
      end
    end

    def self.all
      orders = []
      CSV.open("support/orders.csv", "r").each do |line|
        data = []
        product_data = line[1].split(/:|;/)
        product_data.each_with_index do |datum, i|
          if i % 2 == 0
            data << datum.to_s
          elsif i % 2 == 1
            data << datum.to_f.round(2)
          end
        end
        order = new(line[0].to_i, Hash[*data])
        orders.push(order)
      end
      return orders
    end

    def self.find(id)
      orders = self.all
      if id > orders.length || id <=0
        raise ArgumentError.new('Invalid ID.')
      else
        return orders[id-1]
      end
    end

  end
end
