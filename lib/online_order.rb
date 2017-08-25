require 'csv'
require_relative 'customer'
require_relative 'order'

module Grocery

  class OnlineOrder < Grocery::Order

    attr_reader :customer, :status

    def initialize(id, products, customer, status = :pending)
      @id = id #id: int, products: {item: price}
      @products = products
      @customer = customer #Customer object
      @status = status
    end

    def total
      total = super
      #no products/empty hash
      total != 0 ? total += 10 : total = 0
    end

    def add_product(product_name, product_price)
      if @status == :pending || @status == :paid
        new_product = { product_name => product_price }
        can_successfully_add = false
        @products.has_key?(product_name) ? can_successfully_add = false : can_successfully_add = true
        if can_successfully_add
          @products.merge!(new_product) { |key, old_value, new_value| old_value }
        end
        return can_successfully_add
      end
      raise ArgumentError.new("Status is neither pending nor paid")
    end

    def self.all
      #Path.expand(__FILE__, relative file path)
      all_orders = []
      CSV.read("support/online_orders.csv").each do |order|
        #0 id, 1 product string, 2 customer id, 3 status
        id = order[0].to_i
        products = {}
        @item_price_array = order[1].split(";")
        #still [item:price, item:price], need to put in hash
        @item_price_array.each do |product|
          split_product = product.split(":")
          item = split_product[0]
          price = split_product[1]
          product_hash = {item => price}
          products.merge!(product_hash)
        end
        customer = Grocery::Customer.find(order[2].to_i)
        status = order[3].to_sym
        all_orders << Grocery::OnlineOrder.new(id, products, customer, status)
      end
      return all_orders
    end

  end
end
