require 'csv'
module Grocery

  class Order

    attr_reader :id, :products

    def initialize(id, products)
      @id = id
      @products = products

    end

    def self.all
      #Path.expand(__FILE__, relative file path)
      all_orders = []
      CSV.read("support/orders.csv").each do |line|
        id = line[0].to_i
        products = {}
        @item_colon_price_array = line[1].split(";")
        #still [item:price, item:price], need to put in hash
        @item_colon_price_array.each do |product|
          split_product = product.split(":")
          item = split_product[0]
          price = split_product[1]
          product_hash = {item => price}
          products.merge!(product_hash)
        end
        all_orders << Grocery::Order.new(id, products)
      end
      return all_orders
    end

    def self.find(id)
      self.all.each do |order|
        return order if order.id == id
      end
      raise ArgumentError.new("An order with the ID #{id} does not exist.")
    end

    def total
      total = 0
      @products.values.each do |price|
        total += price
      end
      total += (0.075 * total).round(2)
    end

    def add_product(product_name, product_price)
      new_product = { product_name => product_price }
      can_successfully_add = false
      @products.has_key?(product_name) ? can_successfully_add = false : can_successfully_add = true
      @products.merge!(new_product) { |key, old_value, new_value| old_value }
      return can_successfully_add
    end

    def remove_product(product_name)
      deleted_value = @products.delete(product_name)
      if deleted_value == nil
        return false
      else
        return true
      end
    end

  end
end
