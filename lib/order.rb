require 'csv'

module Grocery

def self.isabel
  return "cute doge"
end

  class Order
    attr_reader :id, :products

    def initialize(id, products = 0)
      @id = id
      @products = products
    end

    def self.all
      all_orders =[]
      CSV.read('support/orders.csv').each do |row|
        id = row[0]
        products_hash = {}
        product_row = row[1].split(";")
        product_row.each do |pair|
          pairs = pair.split(":")
          products_hash[pairs[0]] = pairs[1]
        end # end of product_row
        all_orders.push(Grocery::Order.new(id, products_hash))
      end #end of csv
      return all_orders
    end # end of load_data

  def self.find(input_id)
    all_orders = self.all
    finder = false
    while finder == false
      all_orders.each do |unique_order|
        if unique_order.id == input_id
          finder = true
          return unique_order
        end
      end
      raise ArgumentError.new "ID does not exit"
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
  # def self.all
  #   return @@all_orders
  # end
  end # end of Order class
end # end of Grocery module
