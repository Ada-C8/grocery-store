require 'csv'
module Grocery

  class Order
    attr_reader :id, :products

    @@all_orders = []
    def load_data
      @@all_orders.replace([])
      CSV.read('../support/orders.csv').each do |row|
        @@all_orders.push(row)
      end
    end
    # def guille
    #   return @name
    # end
    def initialize(id, products = 0)
      @id = id
      @products = products
      CSV.read('../support/orders.csv').each do |row|
        @@all_orders.push(row)
      end
    end

    def total
      sum = 0
      @products.values.each do |price|
        sum += price
      end
      sum = sum + (sum * 0.075).round(2)
    end

    def add_product(product_name, product_price)
      if @products.has_key?(product_name)
        return false
      else
        @products[product_name] = product_price
        return true
      end
    end

    def remove_product(product_name)
      if !@products.has_key?(product_name)
        return false
      else
        @products.delete(product_name)
        return true
      end
    end
  def self.all
    return @@all_orders
  end
  end # end of Order class
end # end of Grocery module
