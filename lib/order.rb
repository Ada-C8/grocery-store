require 'csv'

module Grocery
  class Order
    attr_reader :id, :products

    def initialize(id, products)
      #raise argument error if id or order is a negative number

      if id < 1
        raise ArgumentError.new("Invalid id: #{id}")
      end

      unless products.is_a?(Hash)
        raise ArgumentError.new("Invalid product(s): #{products}")
      end

      @id = id
      @products = products
      # a collection of products and their cost
      # zero products is permitted
      # you can assume that there is only one of each product
    end


    # calculate the total cost of the order by:
    # summing up the products
    # adding a 7.5% tax
    # ensure the result is rounded to two decimal places
    def total
      add_products = 0
      @products.each_value do |cost|
        add_products += cost
      end
      total = (add_products + (add_products * 0.075)).round(2)
      return total
    end

    # take in two parameters, product name and price, and add the data to the product collection
    # It should return true if the item was successfully added and false if it was not
    def add_product(product_name, product_price)
      # pair_present?(hash_name,'key', value)
      if @products.key?(product_name) == true
        return false
      else
        @products[product_name] = product_price
        return true
      end
    end

    # Add a remove_product method to the Order class which will take in one parameter, a product name, and remove the product from the collection
    # It should return true if the item was successfully remove and false if it was not
    def remove_product(product_name)
      if @products.key?(product_name) == true
        @products.delete(product_name)
        return true
      else
        return false
      end
    end

    def self.all(file)
      #return collection of order objects (don't need class variable)

      id = nil
      products_arr = []
      products = {}
      all_orders = []
      csv_file = (CSV.open(file, 'r'))

      csv_file.each do |line|
        id = line[0].to_i
        products_arr = line[1].split(';')
        products = Hash[products_arr.map { |i| i.split(":") }]
        products = Hash[products.keys.zip(products.values.map(&:to_f))]
        # Hash[h.map {|k, v| [k, v.to_f] }]
        order = Grocery::Order.new(id, products)
        all_orders << order
      end

      return all_orders
    end

    def self.find(id) #have to pass in csv file?
      orders = Grocery::Order.all('support/orders.csv')

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





# def self.all
#   #return collection of order objects (don't need class variable)
#
#   id = nil
#   products_arr = []
#   products = {}
#   all_orders = []
#
#   CSV.open('support/orders.csv', 'r').each do |line|
#     id = line[0].to_i
#     products_arr = line[1].split(';')
#     products = Hash[products_arr.map { |i| i.split(":") }]
#     products = Hash[products.keys.zip(products.values.map(&:to_f))]
#     # Hash[h.map {|k, v| [k, v.to_f] }]
#     order = Grocery::Order.new(id, products)
#     all_orders << order
#   end
#
#   return all_orders
# end
