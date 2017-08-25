require 'csv'

module Grocery
  class Order
    attr_reader :id, :products

    def initialize(id, products)
      @id = id
      @products = products
    end

    def self.all
      all_orders = []
      CSV.open("/Users/kimberley/ada/week-three/grocery-store/support/orders.csv", "r").each do |line|
        id = line[0].to_i
        line.delete_at(0)
        line = line[0].split(";")
        products = []
        line.each do |item_info|
          item_pair = item_info.split(":")
          item_with_cost = {item_pair[0] => item_pair[1]}
          products << item_with_cost
        end
        order = Grocery::Order.new(id, products)
        all_orders << order
      end
      return all_orders
    end

    def self.find(id)
      self.all.each do |order|
        if id == order.id.to_i
          return order
        end
      end
      if id.to_i > self.all.count || id.to_i < 1
        raise ArgumentError.new ("That order ID does not exist.")
      end
    end

    def total
      if @products.length == 0
        return 0
      else
        order_total = 0
        @products.each do |name, cost|
          order_total += cost
        end
        return (order_total + (order_total * 0.075).round(2))
      end
    end

    def add_product(product_name, product_price)
      if @products.keys.include?(product_name)
        return false
      else
        @products.store(product_name, product_price)
        return true
      end
    end

    def remove_product(product_name)
      @products.delete(product_name)
      @products.each do |name, cost|
        if name == product_name
          return false
        else
          return true
        end
      end
    end

  end # end of class
end # end of module
