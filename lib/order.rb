require 'csv'
require 'pry'

module Grocery

  class Order
    attr_reader :id, :products
    TAX = 0.075

    def initialize(id, products)
      @id = id
      @products = products
      @total = 0
    end

    def self.all
      all_orders = []

      all_orders_by_row = self.order_info_by_row("support/orders.csv")

      all_orders_by_row.each do |order|
        order = Order.new(order[0].to_i,order[1])
        all_orders << order
      end

      return all_orders

    end

    def self.find(id)
      self.all.each {|order| return order if order.id == id}
      raise ArgumentError.new "Sorry, we don't have an order matching that ID number."
    end

    def total

      pretax_total = 0

      if @products.count > 0
        @products.each do |product, price|
          pretax_total += price
        end
      end

      @total = (pretax_total + (pretax_total * TAX)).round(2)
    end

    def add_product(product_name, product_price)

      unless @products.keys.include?(product_name)
        @products[product_name] = product_price
        return true
      end

      return false
    end

    def remove_product(product_name)
      #potentially, check for case
      if @products.keys.include?(product_name)
        @products.delete(product_name)
        return true
      end

      return false
    end


    def self.order_info_by_row(csv_file="support/orders.csv")
      #stores a properly, comma separated row for each Object (order or online order)
      all_order_info = []

      CSV.open(csv_file, "r").each do |row|
        all_order_info << row
      end

      ###loop below will replace the second index with a hash of product info
      all_order_info.each do |order_info|
        product_info = order_info[1].gsub(":", ",").gsub(";", ",").split(",")
        order_products = {}
        idx = 0

        while idx < product_info.length
          order_products[product_info[idx]] = product_info[idx + 1].to_f
          idx += 2
        end

        order_info[1] = order_products
      end

      return all_order_info

    end

  end #end of Order class


end # end module
