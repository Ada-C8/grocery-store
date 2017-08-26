#include Grocery
require_relative 'order'
require_relative 'customer'

class OnlineOrder < Grocery::Order

  @@all_online_orders = Array.new

  attr_reader :customer_id, :status

  def initialize(id, products, customer_id, status)
    super(id, products)
    @customer_id = customer_id
    @status_array = [:pending, :paid, :processing, :complete]
    if @status_array.include?(status.downcase)
      @status = status
    else @status = :pending
    end
  end #init

  def total
    @total = super + 10.00
    return  @total
  end #total method

  def self.all_online
    products = {}
    @@all_online_orders = []

    CSV.open('../support/online_orders.csv', 'r').each do |line|
      id = line[0].to_i #assign ids
      customer_id = line[2].to_i
      status = line[3].to_sym
      semi_colon_split = line[1].split(';') #split out products by dividing by semi colons
      semi_colon_split.each do |item|
        colon_split = item.split(":") #split prices from products
        semi_colon_split.length.times do
          products[colon_split[0]] = colon_split[1] #assign prices to products in the products hash
        end # length.times do
      end #of x.each do
      #@@all_online_orders << OnlineOrder.new(id, products, customer_id, status)
      @@all_online_orders << OnlineOrder.new(id, products, Grocery::Customer.find(customer_id), status)

      #(12, "amy@this.com", "123 Fake St., Dayton, Ohio, 12121")
      products = {}
    end #
    return @@all_online_orders
  end #all method

  def add_product(product_name, product_price, status)
    status = status.downcase.to_sym
    if status == :paid || status == :pending
      puts "That worked "
    else
      raise ArgumentError
    end #if statment
  end #add_product
#   The add_product method should be updated to permit a new product to be added ONLY if the status is either pending or paid (no other statuses permitted)
# Otherwise, it should raise an ArgumentError (Google this!)
end #class



j = OnlineOrder.all_online

j.each do |order|
  puts "Customer id is #{order.customer_id.inspect}"
end

# end
# x = OnlineOrder.new(19, {cheese:5.00, bacon:5.00}, Grocery::Customer.new(12, "amy@this.com", "123 Fake St., Dayton, Ohio, 12121"), :christmas)
# puts "#{x }"
# puts "id is #{x.id}"
# puts "Products are #{x.products}"
# puts "Customer id is #{x.customer_id} and it is class #{x.customer_id.class}"
# puts "Status is #{x.status}"
# puts "Total is #{x.total}"


# A customer object
# A fulfillment status (stored as a Symbol)
# pending, paid, processing, shipped or complete
# If no status is provided, it should set to pending as the default
