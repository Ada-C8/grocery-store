require 'csv'
require_relative 'order'
require_relative 'customer'

module Grocery
  class OnlineOrder < Order
    attr_reader :id, :products, :product_list, :status, :customer, :customer_id

    def initialize(id, products, customer_id, status = :pending)
      @id = id
      @products = products
      @product_list = products.split(";")
      get_products(@product_list)
      @customer_id = Customer.find(customer_id)
      @status = status.to_sym
    end

    def self.all
      list = []
      CSV.read("./support/online_orders.csv").each do |row|
        list << OnlineOrder.new(row[0],row[1],row[2],row[3])
      end
      list
    end

    def self.find_by_customer(search_id)
      list = []
      all.each do |online_order|
        list << online_order if online_order.customer_id.id == search_id
      end
      list.empty? ? (raise ArgumentError.new("This customer doesn't exist.")) : list
    end

    def add_product(product_name, product_price)
      if [:pending, :paid].include? self.status
        super
        return true
      else
        raise ArgumentError.new("Order's status is #{self.status.to_s}.")
      end
    end

    def total
      @product_list == [] ? super : super + 10
    end

    private

    def get_products(info_array)
      @products = {}
      @product_list.each do |productandprice|
        prodprice_arr = productandprice.split(":")
        @products[prodprice_arr[0]] = prodprice_arr[1]
      end
      return @products
    end

  end
end
