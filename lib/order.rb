require 'csv'

module Grocery
  class Order
    attr_reader :id, :products

    def initialize(id, products)
      @id = id
      @products = products
    end

    def self.all
      list = []
      CSV.read("./support/orders.csv").each do |row|
        list << Order.new(row[0], row[1..-1])
      end
      list
    end

    def self.find(id)
      all.each do |order|
        if order.id == id
          return order
        end
      end
      raise ArgumentError.new("Order doesn't exist.")
    end

    def total
      total = 0
      unless @products.empty?
        @products.each do |product_name, product_price|
          total += (product_price.to_f)
        end
        total += total * (7.50/100)
      end
      return total.round(2)

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
      @products.has_key?(product_name) ? @products.delete(product_name) && true : false
    end
  end

end #module Grocery
