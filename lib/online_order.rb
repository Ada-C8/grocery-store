require 'pry'

module Grocery

  class OnlineOrder < Order
    attr_reader :id, :products, :customer, :status

    def initialize(id,products,customer,status= :pending)
      super(id,products)
      @customer = customer
      @status = status
    end

    def self.all

      all_online_orders = []
      all_online_orders_by_row = self.order_info_by_row("support/online_orders.csv")

      all_online_orders_by_row.each do |online_order|
        order = OnlineOrder.new(online_order[0].to_i,online_order[1], Grocery::Customer.find(online_order[2].to_i),online_order[3].to_sym)

        all_online_orders << order
      end

      return all_online_orders

    end #end self.all

    def total
      if @products.count >0
        @total = super + 10
      else
        @total = super
      end
    end

    def add_product(product_name, product_price)
      if @status == :pending || @status == :paid
        return super
      end

      return false
    end

    def self.find_by_customer(customer_id)
      customers_orders = []
      self.all.each {|online_order| customers_orders << online_order if online_order.customer.id == customer_id}

      raise ArgumentError.new "Sorry, we don't have an order matching that customer ID number." if customers_orders.empty?

      return customers_orders
    end

    def self.order_info_by_row(csv_file)
      super(csv_file="support/online_orders.csv")
    end

  end #Online Order class

end #end Grocery module
