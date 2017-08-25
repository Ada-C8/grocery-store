require 'csv'
require_relative 'order'

module Grocery
  class OnlineOrder < Order

    attr_reader :customer_id, :status

    def initialize(id, products, customer_id, status=:pending)
      super(id, products)
      @customer_id = customer_id
      @status = status
    end

    def total
      if products.length > 0
        return super + 10
      else
        return super
      end
    end

    def add_product(product_name, product_price)
      if @status == :paid || @status == :pending
        return super
      else
        raise ArgumentError.new("Too late to add a new product")
      end
    end

    def self.order_from_line(line)
      products = self.products_from_line(line)
      return Grocery::OnlineOrder.new(line[0].to_i, products, line[2].to_i, status="#{line[3]}".to_sym)
    end
    
    def self.all(file)
      orders = []
      CSV.open(file, "r").each do |line|
        orders << self.order_from_line(line)
      end
      return orders
    end

    def self.find_by_customer(customer_id, file)
      customer_orders = []
      CSV.open(file, "r").each do |line|
        if line[2] == customer_id.to_s
          customer_orders << self.order_from_line(line)
        end
      end
      if customer_orders.length > 0
        return customer_orders
      else
        raise ArgumentError.new("Customer not found")
      end
    end










  end #end of class OnlineOrder

end #end of module Grocery
