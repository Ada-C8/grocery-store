require 'pry'
module Grocery

  require_relative 'order'

  class OnlineOrder < Order
    attr_reader :c_id, :status

    def initialize(id, products, customer_id, status)
      super(id, products)
      @c_id = customer_id
      @status = status
    end

    #CLASS METHODS
    def self.all
      all_online_orders = Array.new

      CSV.read('support/online_orders.csv').each do |row_order|
        data_id = row_order[0]
        row_items = row_order[1].split(";")
        #array format to hash
        data_products = Hash.new
        row_items.each do |pair|
          key = pair.to_s.partition(":").first
          value = pair.to_s.partition(":").last
          data_products.store( key, value)
        end

        all_online_orders << OnlineOrder.new(data_id, data_products, row_order[2],row_order[3])
      end

      return all_online_orders
    end

    def self.find_by_customer(customer_id)
      all_online_orders = self.all
      customer_orders = Array.new

      all_online_orders.each do |order|
        if order.c_id == customer_id.to_s
          customer_orders << order
        end
      end
      
      return customer_orders
    end

    # INSTANCE METHODS
    def total
      shipping = 10
      if @products.length != 0
        super + shipping
      else
        super
      end
    end

    def add_product(product_name, product_price)
      case @status
      when "processing", "shipped", "completed"
        return false
      else
        return super(product_name, product_price)
      end
    end

  end #OnlineOrder
end #module
