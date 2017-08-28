module Grocery
  require 'csv'
  require_relative 'order'
  require_relative 'customer'

  class OnlineOrder < Grocery::Order
    attr_reader :customer, :status

    def initialize(id, products, customer, status=:pending)
      super(id, products)
      @customer = customer
      @status = status
    end

    def total
      if @products.length == 0
        return super
      else
        return super + 10
      end
    end

    def add_product(product_name, product_price)
      unless @status == :pending || @status == :paid
        raise ArgumentError.new ("Unable to add products at this time.") #ArgumentError may not have been the appropriate exception to choose here? I was still able to pass a test with no arguments but it failed using other exceptions
      else
        return super(product_name, product_price)
      end
    end

    def self.all
      all_online_orders = []
      CSV.open("support/online_orders.csv", 'r').each do |line|
        id = line[0].to_i
        products = {}
        line[1].split(";").each do |item|
          details = item.split(":")
          products[details[0]] = details[1]
        end
        customer_id = line[2].to_i
        status = line[3]
        all_online_orders << self.new(id, products, customer_id, status)
      end
      return all_online_orders
    end

    def self.find(id)
    end

    def self.find_by_customer(customer_id)
    end
  end # end of class
end # end of module
