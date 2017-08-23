require 'csv'

module Grocery

def isabel
  return "cute doge"
end

  class Order
    attr_reader :id, :products

    @@all_orders = []
    def self.all
      @@all_orders.replace([])
      CSV.read('../support/orders.csv').each do |row|
        id = row[0]
        products_hash = {}
        product_row = row[1].split(";")
        product_row.each do |pair|
          pairs = pair.split(":")
          products_hash[pairs[0]] = pairs[1]
        end # end of product_row
        @@all_orders.push(Grocery::Order.new(id, products_hash))
      end #end of csv
      return @@all_orders
    end # end of load_data

    def initialize(id, products = 0)
      @id = id
      @products = products
    end
    # def initialize(id, products = 0)
    #   @id = id
    #   @products = products
    #   @@all_orders.replace([])
    #   product_hash = {}
    #   CSV.read('../support/orders.csv').each do |row|
    #     @@all_orders.push(row)
    #     @id = row[0]
    #     product_row = row[1].split(";")
    #     product_row.each do |pair|
    #       pairs = pair.split(":")
    #       pairs.each do |product_price|
    #         product_hash[product_price[0]] = product_price[1]
    #       end # end of pairs
    #     end # end of product_row
    #   end #end of csv
    #   @products = @product_hash
    # end

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
  # def self.all
  #   return @@all_orders
  # end
  end # end of Order class
end # end of Grocery module
