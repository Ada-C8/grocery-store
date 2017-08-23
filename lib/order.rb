require 'csv'

module Grocery
  TAX = 0.075


  class Order
    attr_reader :id, :products, :no_orders
    attr_accessor :all, :order_data

    # Class methods
    def self.all
      all = Array.new
      CSV.open('support/orders.csv', 'r+').each do |row_order|
        #array format to hash
        id = row_order[0]
        products = Array.new
        row_items = row_order[1].split(";")
        row_items.each do |pair| #Slivered Almonds:22.88
          products << {pair.to_s.partition(":").first.to_s => pair.to_s.partition(":").last}
        end
        all << Order.new(id,products)
      end

      return all
    end

    def initialize(id, products)
      @id = id
      @products = products #as hashes with key of "product" and value of cost
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
