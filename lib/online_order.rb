require 'pry'
require 'csv'
require_relative 'order'

module Grocery
  class OnlineOrder < Order

    attr_reader :customer_id, :status
    @@all_online_orders = []
    def initialize(id, products, customer_id, status="pending" )
      super(id, products)
      @customer_id = customer_id
      @status = status.to_sym
    end

    #no super because super takes the out put for orders and gives back @@all_orders, in this case we dont care about that we want all the online orders

    #1,Lobster:17.18;Annatto seed:58.38;Camomile:83.21,25,complete
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

    def self.find
      super
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
        raise ArgumentError.new("Error - Cannot add new products at this point in your order.")
      end
    end
  end
end
