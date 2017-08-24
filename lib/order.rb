#require_relative '../support/orders'
require 'CSV'
module Grocery
  class Order
    attr_reader :id, :products


    @@order_objects = []

    def initialize(id, products)
      @id = id
      @products = products
      @original_length = @products.length
    end



    def self.all
      #returns all the orders in the csv file
      @@line_count = 0
      CSV.open("support/orders.csv", 'r').each do |line|
        @@line_count += 1
        id = line[0]
        product_hash ={}
        product_array = line[1].split(';')
        product_array.each do |info|
          smaller_array = info.split(':')
          product_hash[smaller_array[0]] = smaller_array[1]
        end
        @@order_objects << Order.new(id, product_hash)
      end
      return @@order_objects
    end
    #
    # def self.order_objects
    #   return @@order_objects
    # end

    # def self.order_objects
    #   return true
    # end



    def self.order_objects
      @@order_objects.each do |order|
        if order.class != Order
          return false
        else
          return true
        end
      end
    end

    def self.count
      # puts @@line_count
      # puts @order_objects.length
      if @@order_objects.length == @@line_count
        return true
      else
        return false
      end
    end

  # if @orders.length != @line_count
  #   return false
  # end

  # @orders.each |object|
  #   unless object.class == Order
  #     return false
  #   end
  # end




  # def self.find(id)
  #   @orders.each do |order|
  #     if order.id == id
  #       return order
  #     end
  #
  #
  #     #returns the order of that has the passed id
  #   end

  def total
    #: implement total
    @total = 0
    @products.each do |product, price|
      @total += price + price*(0.075)
    end
    return @total.round(2)
  end

  def add_product(product_name, product_price)
    #  implement add_product
    @products.each do |product, price|
      if product == product_name
        return false
      end
    end
    @products[product_name] = product_price
    return true
  end

  def remove_product(product_name)
    @products.delete(product_name)
    if products.length == @original_length
      return false
    else
      return true
    end
  end
end
end



# puts Grocery::Order.count
