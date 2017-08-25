require 'csv'
require 'awesome_print'
require 'pry'

require_relative 'order'
require_relative 'customer'

module Grocery

  class OnlineOrder < Order
  # The OnlineOrder class will inherit behavior from the Order class and include additional data to track the customer and order status.
    attr_reader :id, :products, :customer, :order_status

    def initialize(id, products, customer, order_status = :pending)
      @id = id
      @products = products
      @customer = customer # or? Grocery::Customer.all
      @order_status = order_status
      status_array = [:pending, :paid, :processing, :shipped, :complete]
    end

    def total
      if super > 0
        total = super + 10
        return total
      end
      #else
        #raise ArgumentError.new("Your order is empty so we cannot add shipping!")
    end

    def add_product(product_name, product_price)
    # The add_product method should be updated to permit a new product to be added ONLY if the status is either pending or paid (no other statuses permitted)
    acceptable_status = [:pending, :paid]

      if acceptable_status.includes?(@order_status)
        if @products.keys.include?(product_name)
          return false
        else
          @products[product_name] = product_price
          return true
        end
      else
        raise ArgumentError.new("You can only add products to the order if the status is pending or paid.")
      end
    end

    def self.all
      orders_array = []
      CSV.read('./support/online_orders.csv').each do |row|
        products_hash = {}
        products_colon = row[1].split(";")
        products_colon.each do |e|
          k = e.split(":").first
          v = e.split(":").last
          products_hash.merge!({k => v})
        end
        orders_array << Grocery::Order.new(row[0], products_hash)
      end
      return orders_array
      # puts "This is the orders_array:"
      # ap orders_array
    end

    def self.find(input_id)
      ordered_stuff = {}
      #if id > 1 && id <@orders_array.length
        my_order = Grocery::OnlineOrder.all
        my_order.each do |order|
          if order.id == input_id
            ordered_stuff = order.products
            return ordered_stuff
          end
        end
        if ordered_stuff.empty?
          raise ArgumentError.new("You did not enter a valid order number.")
        end
    end

  end #end of class OnlineOrder
end #end of module

Grocery::OnlineOrder.all
