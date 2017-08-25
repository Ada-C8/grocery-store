require 'csv'

module Grocery
  class Order
    attr_reader :id, :products

    def initialize(id, products)
      @id = id
      @products = products
    #   @products = products.join(",")
    #   @product_list = @products.split(",")
    #   @products = {}
    #   @product_list2 = @product_list.join.split(";")
    #   @product_list2.each do |productandprice|
    #    prodprice_arr = productandprice.split(":")
    #    @products[prodprice_arr[0]] = prodprice_arr[1]
    #  end
  
      split_order_info(@products)
      get_products(@product_list)
    end

    def split_order_info(products)
        @product_list = products.split(";")
        return @product_list
    end

    def get_products(info_array)
      @products = {}
      product_list2 = @product_list.join(";").split(";")
      product_list2.each do |productandprice|
        prodprice_arr = productandprice.split(":")
        @products[prodprice_arr[0]] = prodprice_arr[1]
      end
      return@products
    end

    def self.all
      list = []
      CSV.read("../support/orders.csv").each do |row|
        list << Order.new(row[0], row[1..-1].join(";"))
      end
      list
    end

    def self.find(id)
      all.each do |order|
        if order.id == id
          return order
        end
      end
      raise ArgumentError.new("Order doesn't exist.")
    end

    def total
      total = 0
      unless @products.empty?
        @products.each do |product_name, product_price|
          total += (product_price.to_f)
        end
        total += total * (7.50/100)
      end
      return total.round(2)

    end

    def add_product(product_name, product_price)
      if @products.has_key?(product_name)
        return false
      else
        @products[product_name] = product_price
        return true
      end
    end

    def remove_product(product_name)
      @products.has_key?(product_name) ? @products.delete(product_name) && true : false
    end
  end

myord = Order.new(CSV.read("../support/orders.csv")[0][0],CSV.read("../support/orders.csv")[0][1])
  puts myord.add_product("nameofprod","45")
  puts myord.total
 puts myord.id
 puts myord.products
 puts Order.all
puts Order.find("1")

end #module Grocery
