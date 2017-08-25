require 'csv'
module Grocery
  class Order

    attr_reader :id, :products

    def initialize(id, products)
      @id = id
      @products = products
    end

    def total
      sum = 0.0
      @products.each do |product, price|
        sum += price
      end
      return (sum * 1.075).round(2)
    end

    def add_product(product_name, product_price)
      if !@products.key?(product_name)
        @products[product_name] = product_price
        return true
      end
      return false
    end

    def remove_product(product_name)
      if @products.key?(product_name)
        @products.delete(product_name)
        return true
      end
      return false
    end

    def self.products_from_line(line)
      products = {}
      line[1].split(";").each do |product|
        products[product.split(":")[0]] = product.split(":")[1]
      end
      return products
    end

    def self.order_from_line(line)
      products = self.products_from_line(line)
      return Grocery::Order.new(line[0].to_i, products)
    end

    def self.all(file)
      orders = []
      CSV.open(file, "r").each do |line|
        orders << self.order_from_line(line)
      end
      return orders
    end

    def self.find(id, file)
      CSV.open(file, "r").each do |line|
        if line[0] == id.to_s
          return self.order_from_line(line)
        end
      end
      raise ArgumentError.new("ID not found")
    end

  end #end of class Order

end #end of module Grocery
