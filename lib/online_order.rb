require 'csv'
require_relative 'order'
require_relative 'customer'

#OnlineOrder inherits behaviour from Order class
class OnlineOrder < Grocery::Order
  attr_reader :customer, :status
  def initialize(id, products, customer, status = :pending) #paid, processing, shipped, complete
    super(id, products)
    @customer = customer
    @status = status.to_sym
  end

  #total method same total method in Order, except adds $10 shipping fee
  def total
    total_no_shipping = super
    total = nil
    if total_no_shipping == 0
      total = 0
    else#total_no_shipping != 0
      total = total_no_shipping + 10
    end
    return total
  end

  #add_product method permits a new product to be added only if the status is either pending or paid (no other statuses permitted)
  #otherwise it raises an ArgumentError
  def add_product(product_name, product_price)
    unless @status == :pending || @status == :paid
      raise ArgumentError.new("You can't add a product unless your status is pending or paid")
    end
    return super
  end

  #self.all returns a collection of OnlineOrder instances, representing all of the OnlineOrders described in the CSV
  def self.all
    id = nil
    products_arr = []
    products = {}
    status = nil
    all_online_orders = []

    CSV.open('support/online_orders.csv', 'r').each do |line|
      id = line[0].to_i
      status = line[3].to_sym
      products_arr = line[1].split(';')
      products = Hash[products_arr.map { |i| i.split(":") }]
      products = Hash[products.map {|product, price| [product, price.to_f] }]
      # products = Hash[products.keys.zip(products.values.map(&:to_f))]
      # Hash[h.map {|k, v| [k, v.to_f] }]
      order = OnlineOrder.new(id, products, Grocery::Customer.find(line[2].to_i), status)
      all_online_orders << order
    end
    return all_online_orders
  end

  #self.find(id) returns an instance of OnlineOrder where the value of the id field in the CSV matches the passed parameter
  def self.find(id)
    return super
  end

  #self.find_by_customer(customer_id) eturns a list of OnlineOrder instances where the value of the customer's id matches the passed parameter
  def self.find_by_customer(cus_id)
    online_orders = OnlineOrder.all

    customer_orders = []#stores all orders made by cus_id

    online_orders.each do |order|
      if order.customer.id == cus_id
        customer_orders << order
      else
      end
    end

    return customer_orders
  end

end

# puts OnlineOrder.all[1].customer.email
# puts OnlineOrder.find_by_customer(1).length
