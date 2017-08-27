require 'csv'

module Grocery
  class Order
    attr_reader :id, :products

    def initialize(id, products)
      #raise argument error if id or order is less than 1
      if id < 1
        raise ArgumentError.new("Invalid id: #{id}")
      end
      #raise argument error if product is not a hash
      #zero products is permitted
      unless products.is_a?(Hash)
        raise ArgumentError.new("Invalid product(s): #{products}")
      end

      @id = id
      @products = products
    end

    #total method calculates total cost with tax
    def total
      add_products = 0
      @products.each_value do |cost|
        add_products += cost
      end
      total = (add_products + (add_products * 0.075)).round(2)
      return total
    end

    #all_product method that adds the data to product collection
    #returns true if the item was successfully added and false if it was not
    def add_product(product_name, product_price)
      if @products.key?(product_name) == true
        return false
      else
        @products[product_name] = product_price
        return true
      end
    end

    #remove_product method removes a product from the collection
    #returns true if the item was successfully removed and false if it was not
    def remove_product(product_name)
      if @products.key?(product_name) == true
        @products.delete(product_name)
        return true
      else
        return false
      end
    end

    def self.all
      #return collection of order objects (don't need class variable)
      id = nil
      products_arr = []
      products = {}
      all_orders = []

      CSV.open('support/orders.csv', 'r').each do |line|
        id = line[0].to_i
        products_arr = line[1].split(';')
        products = Hash[products_arr.map { |i| i.split(":") }]
        #products = Hash[products.keys.zip(products.values.map(&:to_f))]
        products = Hash[products.map {|product, price| [product, price.to_f] }]
        order = Grocery::Order.new(id, products)
        all_orders << order
      end

      return all_orders
    end

    def self.find(id)
      orders = Grocery::Order.all

      id_arr = []
      orders.each do |order|
        id_arr << order.id
      end

      unless id_arr.include? (id)
        raise ArgumentError.new("Invalid order id: #{id}")
      end

      return orders[id-1]
    end

  end#Order
end

# puts Grocery::Order.all[0].products
