require 'csv'
require 'pry'
module Grocery

  class Order
    CSVFILE = "support/orders.csv"
    attr_reader :id, :products

    def initialize(id, products)
      @id = id
      @products = products
    end

    def total
      # TODO: implement total
      total = 0
      products.each {|name, price| total += price}
      total = total + (total* 0.075).round(2)
    end

    def add_product(product_name, product_price)
      # TODO: implement add_product
      if !@products.has_key? product_name
        @products[product_name] = product_price
        true
      else
        false
      end
    end

    def remove_product(product_name)
      @products.delete product_name
    end

    def product_keys
      @products.keys
    end

    def self.cost_item_hash(info_array)
      hashy_hash = {}
      while info_array != []
        item = info_array.delete_at(0)
        cost = info_array.delete_at(0)
        hashy_hash[item] = cost
      end
      hashy_hash
    end #end

    #reads csv file for order
    def self.get_csv_info
      CSV.open(CSVFILE, 'r')
    end

    def self.all
      all_orders = []
      (self.get_csv_info).each do |ugly_string_line|
        #sort the ugly string out
        #{id_number => {item => price}}

        info_array = (ugly_string_line[1]).split(/;|:/)

        id_num = (ugly_string_line[0]).to_i
        hashy_hash = self.cost_item_hash(info_array)


        fulfillment_status = ugly_string_line[3]
        customer_id = ugly_string_line[2]
        all_orders << self.all_online_order_add_arguments(id_num, hashy_hash, customer_id, fulfillment_status)

      end
      all_orders
    end

    def self.all_online_order_add_arguments(id_num, hashy_hash, customer_id, fulfillment_status)
        self.new(id_num, hashy_hash)
    end

    def self.find(number)
      found_it = (Grocery::Order.all).detect{|grocery_order| grocery_order.id == number}
      raise ArgumentError.new("Order Not Found") if found_it == nil
      found_it
    end
  end

end
