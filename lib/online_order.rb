require_relative './order.rb'

module Grocery
  class OnlineOrder < Grocery::Order
    attr_reader :customer
    attr_accessor :status

    def initialize(order_id, customer_id, order_status = :pending, products = nil)
      @id = order_id
      @customer = customer_id
      @products = products
      @status = order_status
    end

    def self.all
      orders = []
      CSV.open('./support/online_orders.csv', "r", headers: true).each do |row|
        order_products = row["products"].split(";")
        products = {}
        order_products.each do |product_price|
          product_hash = product_price.split(":")
          products.store(product_hash[0], product_hash[1].to_f)
        end
        orders << OnlineOrder.new(row["id"].to_i, row["customer_id"], row["status"].to_sym, products)
      end
      orders
    end

    def total
      return @products == nil ? 0 : super + 10
    end

    def print
      puts 'Hi'
    end

    def add_product(product_name, product_price)
      if @status == :pending || @status == :paid
        super
      else
       return "This order cannot be modified."
      end
    end
  end
end


# begin
#   if @status == :pending || @status == :paid
#     super
#   else
#    raise ArgumentError.new("This order cannot be modified.")
#   end
# rescue => e
#   puts e.message
# end
