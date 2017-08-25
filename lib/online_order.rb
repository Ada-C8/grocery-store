require_relative "order.rb"
require_relative "customer.rb"

class OnlineOrder < Grocery::Order
  attr_reader :order, :customer, :status, :id, :products
  # TODO: make the defualt status: "pending"

  def initialize(order, customer, status)
    @order = order
    super(id, products)
    @customer = customer
    @status = status.to_sym
  end


  def total
    return super + 10
  end

  def add_product

    ## if status is pending or paid
    return super
    ## else raise ArgumentError
  end

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
      order = Grocery::Order.new(line[0].to_i, Hash[*data])
      orders.push(OnlineOrder.new(order, Grocery::Customer.find(line[2].to_i), line[3]))
    end
    return orders
  end

end
# test = OnlineOrder.new("customer")
# puts test.status
#
# test = OnlineOrder.new("customer", status: "not pending")
# puts test.status
puts OnlineOrder.all[99].customer.email

# puts OnlineOrder("customer").total
