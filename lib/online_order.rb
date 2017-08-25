require_relative './order'

module Grocery
  class OnlineOrder < Grocery::Order
    attr_reader :id, :customer, :products
    attr_accessor :status

    def initialize(order_id, customer_id, order_status = :pending, products = nil)
      @id = order_id.to_i
      @customer = Grocery::Customer.find(customer_id.to_i)
      @products = products
      @status = order_status.to_sym
    end

    def self.all
      orders = []
      CSV.open('./support/online_orders.csv', "r", headers: true).each do |row|
        order_products = row["products"].split(";")
        products = {}
        order_products.each do |product_price|
          product_hash = product_price.split(":")
          products.store(product_hash[0], product_hash[1].to_f)
        end
        orders << OnlineOrder.new(row["id"], row["customer_id"], row["status"], products)
      end
      orders
    end

    def self.find(id_num)
      orders = OnlineOrder.all
      ids = []
      orders.each do |order|
        ids << order.id
        return order if order.id == id_num
      end
      if !(ids.include?(id_num))
        return "Invalid Order Number"
      end
    end

    def self.find_by_customer(customer_id)
      orders = OnlineOrder.all
      customer_orders = []
      orders.each do |order|
        if order.customer.id == customer_id
          customer_orders << order
        end
      end
      if customer_orders.empty?
        return "Customer does not exist."
      end
      customer_orders
    end

    def total
      return @products == nil ? 0 : super + 10
    end

    def print
      puts 'Hi'
    end

    def add_product(product_name, product_price)
      if @status == :pending || @status == :paid
        super
      else
       return "This order cannot be modified."
      end
    end
  end
end


# begin
#   if @status == :pending || @status == :paid
#     super
#   else
#    raise ArgumentError.new("This order cannot be modified.")
#   end
# rescue => e
#   puts e.message
# end
