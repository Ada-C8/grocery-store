require 'csv'
require 'order'
require 'customer'
module Grocery
  class OnlineOrder < Order
    attr_reader :customer, :status

  def initialize(id, products, customer, status = :pending)
    super id,  products
    @customer = customer
    @status = status
  end

  def self.all
      online_orders = []
      CSV.read('./support/online_orders.csv').each do |row|
        #[1, "banana:2;sandwich:2"]
        #row.each do |single_order|
          id = row.delete_at(0).to_i
          status = row.delete_at(-1).to_sym
          customer = row.delete_at(-1).to_i
          #["banana:2;sandwich:2"]
          products_array = row.join(' ')
          products_array = products_array.split(';')
           #["banana:2", "sandwich:2"]
           products = products_array.map { |i| i.split ':' }.to_h
           online_orders << self.new(id, products, customer, status)
         end
         return online_orders
  end

  def self.find(id)
    #not clear on how I can use super here.
    online_orders = Grocery::OnlineOrder.all
    online_orders.each do |element|
        if element.id == id
          return OnlineOrder.new(element.id, element.products, element.customer, element.status)
        end
    end
    raise ArgumentError.new("Id does not exist.")
  end

  def self.find_by_customer(customer_id)
    customer_orders = []
    online_orders = Grocery::OnlineOrder.all
    online_orders.each do |order_instance|
        if order_instance.customer == customer_id
          customer_orders << order_instance
        end
      end
    if customer_orders.length == 0
    raise ArgumentError.new("Customer ID does not exist.")
     else
    return customer_orders
    end
  end

  def total
    @total = super
    if @total > 0
    return (super + 10.00)
  else
    return 0
    end
  end

  def add_product(product_name, product_price)
    if @status == :pending || @status == :paid
      return super
    else
      raise ArgumentError.new("Cannot add product unless pending or paid.")
    end
  end

  end
end
