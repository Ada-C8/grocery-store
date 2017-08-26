require 'pry'
require 'csv'
require_relative 'order'

module Grocery
  class OnlineOrder < Order

    attr_reader :customer_id, :status

    def initialize(id, products, customer_id, status="pending" )
      super(id, products)
      @customer_id = customer_id
      @status = status.to_sym
    end

    def self.all
      #no super because super takes the out put for orders and gives back @@all_orders, in this case we dont care about that we want all the online orders
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
