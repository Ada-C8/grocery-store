require 'csv'
#NO! order.rb doesn't need require_relative AT. ALL.
module Grocery

  class Order

    attr_reader :id, :products

    def initialize(id, products)
      @id = id
      @products = products
    end

    #CSV must be in an array
    #in order to test using rake, only one period (instead of two) is needed

    def self.all
      array = []
      CSV.open('../support/orders.csv', 'r').each do |line|    ##
        id = line.shift.to_i
        products = {} ##from produce_hash to products?
        produce = line.shift.split(";")
        produce.each do |items|
          two_item_array = items.split(":")
          item = two_item_array[0]
          price = two_item_array[1]
        # the following line didn't work
        # products.merge({item => price}) ##from produce_hash to products?
          products[item] = price
        end
        array << Order.new(id, products) ##from produce_hash to products?
      end
      #returns object memory address
      return array
    end

    def self.find(id)
      id_array = []
      all_orders = Grocery::Order.all
      all_orders.each do |arr|
        id_array << arr.id
        if id_array.include? id
          return Order.new(arr.id, arr.products)
        end
      end
      raise ArgumentError.new("Invalid parameters for order number")
    end

    def total
      # TODO: implement total
      @total = @products.values.inject(0, :+)
      @total_plus_tax = @total + (@total * 0.075).round(2)
      return @total_plus_tax
    end

    def add_product(product_name, product_price)
      # TODO: implement add_product
      @product_name = product_name
      @product_price = product_price
      @products.each do |key, value|
        if @product_name == key
          return false
        end
      end
      @products[@product_name] = @product_price
      return true
    end
  end


end
