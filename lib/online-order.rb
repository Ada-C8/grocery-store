require 'csv'
require_relative 'order'
require_relative 'customer'

module Grocery
  class OnlineOrder < Order
    attr_reader :id, :products, :product_list, :status, :customer
    def initialize(id, products)
      @id = id
      @products = products
      split_order_info(@products)
      get_order_status(@product_list)
      get_customer(@product_list)
      get_products(@product_list)
      @status
    end

    def self.all
      list = []
      CSV.read("./support/online_orders.csv").each do |row|
        list << OnlineOrder.new(row[0], row[1..-1])
      end
      list
    end

    def self.find_by_customer(customer_id)
      list = []
      all.each do |online_order|
        list << online_order if online_order.id == customer_id
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
      @product_list == [""] ? super : super + 10
    end

    private
    def split_order_info(products)
        @product_list = products.join(";").split(";")
        return @product_list
    end
    def get_order_status(info_array)
      @status = @product_list.pop.to_sym
      return @status
    end
    def get_customer(info_array)
      @customer = Customer.find(info_array.pop.to_s)
    end
  end
end
