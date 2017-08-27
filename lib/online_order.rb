#include Grocery
require_relative 'order'
require_relative 'customer'

class OnlineOrder < Grocery::Order

  @@all_online_orders = Array.new
  @@status_array = [:pending, :paid, :processing, :complete]

  attr_reader :customer_info, :status

  def initialize(id, products, customer_info, status)
    super(id, products)
    @customer_info = customer_info

    if @@status_array.include?(status.to_sym)
      @status = status.to_sym
    else @status = :pending
    end
  end #init

  def total
    if products == {}
      return @total = 0
    else
      @total = super + 10.00
    end
    return @total
  end #total method

  def self.all
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
      products = {}
    end #
    return @@all_online_orders
  end #all method

  # def add_product(mobile_id, product_name, product_price)
  #
  #   if status == :paid || status == :pending
  #     puts "That worked "
  #   else
  #     raise ArgumentError
  #   end #if statment
  # end #add_product
#   The add_product method should be updated to permit a new product to be added ONLY if the status is either pending or paid (no other statuses permitted)
# Otherwise, it should raise an ArgumentError (Google this!)
end #class


# #
# j = OnlineOrder.all
#
# j.each do |order|
#   puts "Id is #{order.id}. Products are #{order.products}. Customer E-mail is #{order.customer_info.customer_id}"
#   puts "Status is #{order.status}"
# end


x = OnlineOrder.new(19, {cheese:5.00, bacon:5.00}, Grocery::Customer.new(12, "amy@this.com", "123 Fake St., Dayton, Ohio, 12121"), :pending)
# # puts "#{x }"
# # puts "id is #{x.id}"
# # puts "Products are #{x.products}"
# # puts "Customer id is #{x.customer_info.customer_id} and it is class #{x.customer_info.class}"
puts "class is #{x.class}"
# puts "Total is #{x.total} and it is class #{x.total.class}"


# A customer object
# A fulfillment status (stored as a Symbol)
# pending, paid, processing, shipped or complete
# If no status is provided, it should set to pending as the default
