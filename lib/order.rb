require 'csv'


module Grocery
  class Order
    attr_reader :id, :products

    def initialize(id, products)
      @id = id
      @products = products

      #raise argument error if id/order < 1
      if id < 1
        raise ArgumentError.new("Invalid id: #{id}")
      end
      #raise argument error if not a hash
      unless products.is_a?(Hash)
        raise ArgumentError.new("Invalid product(s): #{products}")
      end
    end

    #total method sums up products + 7.5% tax, rounded
    def total
      add_products = 0
      @products.each_value do |cost|
        add_products += cost
      end
      total = (add_products + (add_products * 0.075)).round(2)
      return total
    end
    #return true if products includes product, false if not
    def add_product(product_name, product_price)

      if @products.keys.include?(product_name)
        return false
      else
        @products[product_name] = product_price
        #could also have done products.merge!(product_name => product_price)
        return true
      end
    end


    #self.all - returns a collection of Order instances - all CSV. use split.
    def self.all
      id = nil
      products_arr = []
      products = {}
      all_orders = []

      CSV.open('./support/orders.csv', 'r').each do |line|
        id = line[0].to_i
        products_arr = line[1].split(';')
        products = Hash[products_arr.map { |i| i.split(":") }]
        products = Hash[products.keys.zip(products.values.map(&:to_f))]
        order = Grocery::Order.new(id, products)
        all_orders << order
      end

      return all_orders
    end




    #returns instance of Order where the id field matches the parameter.
    def self.find(id)

      orders = Grocery::Order.all

      id = []
      orders.each do |order|
        id << order.id
      end

      unless id.include? (id)
       raise ArgumentError.new("Invalid input")
      end

      return orders[id1]
      #
    end








  end #(class)
end #(module)
