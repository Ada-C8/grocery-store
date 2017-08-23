require 'csv'
require 'pry'
require 'awesome_print'

module Grocery
  class Order
    attr_reader :id, :products, :total, :all_orders, :orders

    def initialize(id, products)
      @id = id
      @products = products
    end



    def self.all(file_name)
      @orders = []
      CSV.open(file_name, "r").each do |row|
        @products = {}
        @id = row[0].to_i
        @product_list = row[1].split(";")
        @product_list.each do |sep|
          food_price_array = sep.split(":")
          @products[food_price_array[0].to_s] = food_price_array[1].to_f
        end
        @orders << Grocery::Order.new(@id, @products)
      end
      return @orders
    end

  def self.find(id)

  end

    def total
      sum = 0
      @products.values.each do |price|
        sum += price
      end
      total = sum + (sum * 0.075).round(2)
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
    return true
  else
    return false
  end
end

  end
end


puts Grocery::Order.all("./support/orders.csv").class 

#
# puts order1.total
#
# puts order1.products.length
#
#
# order1.add_product("kiwi", 1.00)
#
# puts order1.products.length
#
#
# puts order1.total
#
# order1.remove_product("banana", 1.50)
#
# puts order1.products.length
