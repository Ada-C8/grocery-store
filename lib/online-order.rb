require 'csv'
require_relative 'customer'
require_relative 'order'

module Grocery
  class OnlineOrder < Order
    attr_reader :customer
    attr_accessor :status

    def initialize(order_id, products, customer, status = :pending)
      super(order_id, products)
      @customer = customer
      @status = status
    end

    def total
      # adds $10 shipping fee to order
      orig_total = super
      shipping = 10

      if orig_total > 0
        return super + shipping
      else
        return super
      end
    end

    def add_product(product_name, product_price)
      # only adds product if status is pending or paid; returns false if can't be added
      if @status == :pending || @status == :paid
        super
      else
        raise ArgumentError.new("Can only add product to an order that is pending or paid")
      end
    end

    def self.all
      csv = "./support/online_orders.csv"
      all_online_orders = []

      CSV.foreach(csv) do |row|
        order_id = row[0].to_i
        product_info = row[1]
        cust_id = row[2].to_i
        status = row[3].to_sym

        customer = Grocery::Customer.find(cust_id)
        products = parse_products(product_info)

        online_order = Grocery::OnlineOrder.new(order_id, products, customer, status)
        all_online_orders << online_order
      end

      return all_online_orders
    end

    def self.find(id)
      # does this need to be changed? Does this need to be included at all?
      super
    end

    def self.find_by_customer(customer_id)
      
    end

  end # end of OnlineOrder class
end
