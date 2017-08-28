require 'pry'
require 'csv'
require_relative 'order'

module Grocery
  class OnlineOrder < Order

    attr_reader :customer_id, :status
    @@all_online_orders = []
    def initialize(id, products, customer_id, status="pending" )
      super(id, products)
      #  @customer = Grocery::Customer.find(customer_id) #so that we use an instance of the Customer class instead of just the customer_id in the csv file to access data about each customer. I couldn't get this to work and I think it has to do with the fact that I'm using a class variable.
      @customer_id = customer_id
      @status = status.to_sym
    end

    #no super because super takes the out put for orders and gives back @@all_orders, in this case we dont care about that we want all the online orders
    def self.all
      if @@all_online_orders.length > 0
        return @@all_online_orders
      end
      CSV.open("support/online_orders.csv", "r").each do |line|
        id = line[0].to_i
        customer_id = line[2]
        status = line[3]
        products_hash = {}
        products_prices = line[1].split(';')
        products_prices.each do |product|
          ind_product_price = product.split(':')
          products_hash[ind_product_price[0]] = ind_product_price[1].to_f
        end
        @@all_online_orders << self.new(id, products_hash, customer_id, status)
      end
      return @@all_online_orders
    end

    def self.find(id_input)
      counter = 0
      OnlineOrder.all.each do |order|
        if order.id == id_input
          counter += 1
          return order
        end
      end
      if counter == 0
        raise ArgumentError.new("Invalid order number - order does not exist")
      end
    end

    def self.find_by_customer(customer_id_input)
      counter = 0
      orders_array =[]
      OnlineOrder.all.each do |order|
        if order.customer_id == customer_id_input.to_s
          counter += 1
          orders_array << order
        end
      end
      if counter == 0
        raise ArgumentError.new("Invalid customer ID- customer does not exist")
      end
      return orders_array
    end

    def total
      if super != 0
        super + 10
      else
        return 0
      end
    end

    def add_product(product, price)
      case @status
      when :paid, :pending
        super(product, price)
      when :complete, :processing, :shipped
        raise ArgumentError.new("Error - You cannot add new products at this point in you order because your order status is #{status.to_s} .")
      end
    end
  end
end
