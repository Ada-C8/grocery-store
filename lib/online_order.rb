require_relative './order'

module Grocery
  class OnlineOrder < Grocery::Order
    attr_reader :customer, :status

    @@online_orders = []

    def initialize(csv_line)
      raise ArgumentError.new("The input must be an array") if csv_line.class != Array
      @customer = Grocery::Customer.find(csv_line[2].to_i)
      @status = (csv_line[3] == "" ? :pending : csv_line[3].to_sym)
      super
    end

    def total
      return 0 if @products.length == 0
      return (super + 10)
    end

    def add_product(product_name, product_price)
      raise ArgumentError.new("The order status must be paid or pending") unless [:paid, :pending].include?(self.status)
      if @products.keys.include?(product_name)
        return false
      else
        @products[product_name] = product_price
        return true
      end
    end

    def self.read(filename)
      @@online_orders = []
      CSV.foreach(filename) do |line|
        self.new(line)
      end
    end

    def self.all
      return @@online_orders
    end

    def self.find(number)
      @@online_orders.each do |order|
        return order if order.id == number
      end
      raise ArgumentError.new("This order id does not exist")
    end

    def self.find_by_customer(number)
      customer_orders = @@online_orders.size.times.select {|i| @@online_orders[i].customer.id == number}
      return customer_orders
    end

    private

    def collect_instance
      @@online_orders.push(self)
    end

  end
end
