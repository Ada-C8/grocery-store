require 'csv'

module Grocery
  class OnlineOrder < Grocery::Order
    attr_reader :customer_id, :status

    def initialize(id, products, customer_id, status = :pending)
      super(id, products)
      @status = status
      # @customer_id = Grocery::Customer.find(customer_id)
      @customer_id = customer_id
    end

    def total
      if @products.empty?
        total = 0
      else
        total = super + 10
      end
      return total
    end

    def add_product(product_name, product_price)

      if @status != :paid && @status != :pending
        raise ArgumentError.new "Cannot add a new product at this time."
      else
        return super
      end
    end

    def self.all
      @online_orders_all = []
      CSV.read("support/online_orders.csv").each do |row|
        online_order = self.order_from_row(row)
        @online_orders_all << online_order
      end
      return @online_orders_all
    end

    def self.find(id)
      online_orders = Grocery::OnlineOrder.all

        online_orders.each do |order|
          if order.id == id
            return order
          end
        end

        raise ArgumentError.new "This online order does not exist"
    end

    def self.find_by_customer(customer_id)
      Grocery::OnlineOrder.all.select{ |online_order| online_order.customer_id == customer_id }
    end

private

    def self.order_from_row(row)
      id = row[0].to_i
      products = self.parse_product_string(row[1])
      customer_id = row[2].to_i
      status = row[3].to_sym
      OnlineOrder.new(id, products, customer_id, status)
    end

    def self.parse_product_string(product_string)
      pair_strings = product_string.split(';')
      pairs = []
      pair_strings.each do |pair|
        pairs << pair.split(':')
      end
      products = {}
      pairs.to_h.each do |item, cost|
        products[item] = cost.to_f
      end
      return products
    end
  end #end of online_order

end # end of grocery
