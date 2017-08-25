module Grocery
  class Online_Order < Order

    attr_reader :customer, :status
    LEGAL_STATUSES = [:pending, :paid, :processing, :shipped, :complete]

    def initialize(id, products, customer, status = :pending)
      super(id,products)
      # @id = id.to_i
      # @products = products
      @customer = customer
      @status = status
    end

    def set_status(status)
      if LEGAL_STATUSES.include?status
        @status = status
      else
        raise ArgumentError.new("Invalid Status")
      end
    end

    def total
      if super == 0
        return 0
      else
        return super + 10
      end
    end

    def add_product(product_name, product_price)
      if @status == :pending || @status == :paid
        super
      else
        raise Exception.new("Cannot add products to #{@status} order")
      end
    end

    def self.all(online_orders_list, customer_list)
      all_online_orders = []
      customers = Customer.all(customer_list)
      CSV.open(online_orders_list).each do |order|
        id = order[0].to_i
        products = {}
        order[1].split(';').each do |product|
          product_split = product.split(':')
          products[product_split[0]] = product_split[1].to_f
        end
        customer = Customer.find(order[2].to_i,customers)
        status = order[3].to_sym
        all_online_orders << self.new(id, products, customer, status)
      end
      return all_online_orders
    end

    def self.find_by_customer(id, orders_list)
      orders = []
      orders_list.each do |order|
        if order.customer.id == id
          orders << order
        end
      end
      if orders.length == 0
        raise RangeError.new("ID does not exist: #{id}")
      else
        return orders
      end
    end

  end
end
