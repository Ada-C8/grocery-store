require 'csv'
require_relative 'order'
require_relative 'customer'

module Grocery
  class OnlineOrder < Order
    attr_reader :id, :products, :customer
    attr_accessor :status

    def initialize(id, products, customer, status = :pending) #customer needs to be passed in as a customer object
      @id = id
      @products = products
      @customer = customer
      @status = status
    end

    def total
      if @products.empty?
        return 0
      end
      super + 10
    end

    def add_product(product_name, product_price)
      if [:processing, :shipped, :complete].include?(self.status)
        raise ArgumentError.new("This action not permitted for processing, shipped, or completed orders.")
      end
      super
    end

    def self.all
      all_orders = []
      CSV.open("/Users/galeharrington/ada/week3/grocery-store/support/online_orders.csv", 'r').each do |line|
        products_hash = {}
        id = line.slice!(0).to_i
        status = line.slice!(-1).to_sym
        customer = line.slice!(-1).to_i
        line.join.split(";").each do |product| #Eliminate "outer" array. Split resulting string into array of products.
          products_hash[product.split(":")[0]] = product.split(":")[1].to_f #create key, value pair for name, price of product
        end
        all_orders << Grocery::OnlineOrder.new(id, products_hash, customer, status)
      end
      return all_orders
    end

  end
end

ap Grocery::OnlineOrder.find(1)
