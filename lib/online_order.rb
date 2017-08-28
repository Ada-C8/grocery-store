# require_relative "order.rb"
require_relative "customer.rb"

class OnlineOrder < Grocery::Order
  attr_reader  :order, :customer, :status, :id, :products

  # initialize with default status as pending
  def initialize(id, products, customer, status = "pending")
    @id = id
    @products = products
    @order = super(id, products)
    @customer = customer
    @status = status.to_sym
  end

  # adds shipping fee if there are products
  def total
    if @products.empty?
      super
    else
      super + 10
    end
  end

  def add_product(product_name, product_price)
    # adds product if status is pending or paid
    if status == :pending || status == :paid
      return super
    else raise ArgumentError.new("product is not pending or paid")
    end
  end

  # returns array of online orders
  def self.all
    orders = []
    CSV.open("support/online_orders.csv", "r").each do |line|
      data = []
      string = line[1]
      product_data = string.split(/:|;/)
      product_data.each_with_index do |datum, i|
        if i % 2 == 0
          data << datum.to_s
        elsif i % 2 == 1
          data << datum.to_f.round(2)
        end
      end
      orders.push(OnlineOrder.new(line[0].to_i, Hash[*data], Grocery::Customer.find(line[2].to_i), line[3]))
    end
    return orders
  end

  def self.find(id)
    return super
  end

  # returns a single customer's online orders
  def self.find_by_customer(customer_id)
    customer_orders = []
    OnlineOrder.all.each do |online_order|
      if customer_id == online_order.customer.id
        customer_orders.push(online_order)
      end
    end
    return customer_orders
  end
end
