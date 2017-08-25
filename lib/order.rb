require 'csv'
module Grocery
  TAX = 0.075

  class Order
    attr_reader :id, :products
    attr_accessor :all_orders


    # Class methods
    def self.all
      @@all_orders = Array.new

      CSV.read('support/orders.csv').each do |row_order|
        data_id = row_order[0]
        row_items = row_order[1].split(";") #array format to hash
        data_products = Hash.new
        row_items.each do |pair|
          key = pair.to_s.partition(":").first.to_s
          value = pair.to_s.partition(":").last
          data_products.store( key, value)
        end
        @@all_orders << Order.new(data_id, data_products)
      end
      return @@all_orders
    end

    def self.import
    end

    def self.find(line)
      if @@all_orders[line] == nil
        raise ArgumentError.new ("Order does not exist")
      else
        return @@all_orders[line]
      end
    end

    # def self.clear
    #   @@all_orders = Array.new
    # end

    def initialize(id, products)
      @id = id
      @products = products #as hashes with key of "product" and value of cost
      # @@all_orders << self
    end

    # Instance methods
    def total
      if @products.length == 0
        return 0
      else
        return (@products.values.inject(:+) * (1 + TAX)).round(2)
      end
    end

    def add_product(product_name, product_price)
      if @products.keys.include?(product_name)
        return false
      else
        @products.merge!({product_name => product_price})
        return true
      end
    end

    def remove_product(product_name)
      if @products.include?(product_name)
        @products.delete(product_name)
        return true
      else
        return false
      end
    end

  end

end
