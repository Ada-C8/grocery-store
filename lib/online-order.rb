require_relative './order'
require_relative './customer'
require 'pry'

module Grocery
  class OnlineOrder < Order
    attr_reader  :status, :customer

    def initialize(id, products, customer, status: :pending)
      # - A customer object
      # - A fulfillment status (stored as a **Symbol**)
      #   - pending, paid, processing, shipped or complete
      #   - If no status is provided, it should set to pending as the default
      super(id.to_i, products)
      if ![:pending, :paid, :processing, :shipped, :complete].include? status
        raise ArgumentError.new "Not a valid status"
      end
      if customer.class != Grocery::Customer
        raise ArgumentError.new "Not a customer object"
      end
      @customer = customer
      @status = status
    end

    def total
      if @products.keys.length > 0
        return super + 10
      else
        return super
      end
    end

    def add_product(product_name, product_price)
      if @status == :pending || @status == :paid
        super(product_name, product_price)
      else
        raise ArgumentError.new "Your order does not have the right status"
      end
    end

    def self.all(customer_file, csv_file)
      order_array = Grocery::Order.all(csv_file)
      array_of_onlineorders = []
      csv_file.length.times do |i|
        id = order_array[i].id.to_i
        products = order_array[i].products
        csv_line = csv_file[i]
        customer = Grocery::Customer.find(customer_file,csv_line[2].to_i)
        status = csv_line[3].to_sym
        array_of_onlineorders << self.new(id, products,customer, status: status)
      end
      return array_of_onlineorders
    end

    def self.find(customer_file, csv_file,id_lookup)
      order_to_return = nil
      array_of_orders = self.all(customer_file,csv_file)
      array_of_orders.each do |order|
        if order.id == id_lookup
          order_to_return = order
        end
      end
      if order_to_return.nil?
        raise ArgumentError.new "No Order with that Id #"
      end
      return order_to_return
    end

    def self.find_by_customer(customer_file,csv_file,id_lookup)
      orders_to_return = []
      array_of_orders = self.all(customer_file,csv_file)
      array_of_orders.each do |order|
        if order.customer.id == id_lookup
          orders_to_return << order
        end
      end
      return orders_to_return
    end

    def search_id(array_of_things, id_lookup)
      things_to_return = []
      array_of_things.each do |things|
        if things.id == id_lookup
          things_to_return << things
        end
      end
      return things_to_return
    end

  end # end class
end #end module
