require 'csv'
module Grocery
  ### Don't forget to commit
  class Order
    attr_reader :id, :products

    def initialize(id, products)
      @id = id
      @products = products
    end

    def total
      sum = 0
      products.each do |item, cost|
        sum = (sum + cost)
      end
      total = ((sum * 0.075) + sum).round(2)
    end

    def add_product(product_name, product_price)
      if @products.include?(product_name)
        return false
      else
        @products[product_name] = product_price
        return true
      end
    end

    def self.all
      orders = []
      products = {}
      CSV.open("support/orders.csv", "r").each do |line|
        orders << Grocery::Order.new(line[0], products)
        line[1].split(";").each do |element|
          product_list= element.split(":").each do |item, cost|
            products << product_list
          end
        end
      end
    end

  end # end of class
end # module

puts test = Grocery::Order.new(1222, "tomato")
puts test.csv_file
