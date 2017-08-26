# 1,Lobster:17.18;Annatto seed:58.38;Camomile:83.21,25,complete
# 2,Sun dried tomatoes:90.16;Mastic:52.69;Nori:63.09;Cabbage:5.35,10,paid
# 3,Vegetable spaghetti:37.83;Dates:90.88;WhiteFlour:3.24;Caraway Seed:54.29,5,processing
# 4,Aubergine:56.71;Brown rice vinegar:33.52;dried Chinese Broccoli:51.74,35,paid
# 5,Sour Dough Bread:35.11,21,shipped
# 6,Peaches:46.34,14,pending
#include Grocery
require_relative 'order'
require_relative 'customer'

class OnlineOrder < Grocery::Order

  @@all_online_orders = Array.new

  attr_reader :customer_id, :status

  def initialize(id, products, customer_id, status)
    super(id, products)
    @customer_id = customer_id.to_i
    @status = status
  end #init

  def total
    @total = super + 10.00
    return  @total
  end #total method

  def self.all_online
    products = {}

    CSV.open('../support/online_orders.csv', 'r').each do |line|
      id = line[0].to_i #assign ids
      customer_id = line[2].to_i
      status = line[3].to_sym

      x = line[1].split(';') #split out products by dividing by semi colons
      #puts "x is #{x} and it is class #{x.class}"

      x.each do |item|
        y = item.split(":") #split prices from products
        #puts "y is #{y} and it is #{y.class}\n\n"
        x.length.times do
          products[y[0]] = y[1] #assign prices to products in the products hash
          #puts "In the middle of the length times do "
        end # length.times do
      end #of x.each do
      @@all_online_orders << OnlineOrder.new(id, products, customer_id, status)
      products = {}
    end #
    return @@all_online_orders
  end #all method
end #class


puts OnlineOrder.all_online.inspect



# def self.all
#   products = {}
#   CSV.open('../support/orders.csv', 'r').each do |line|
#     id = line[0].to_i #assigns first # in CSV to be the order ID
#     x = line[1].split(';') #splits the orders by semicolons
#     x.each do |item|
#       y = item.split(":") #seperates product name and price
#       x.length.times do
#         products[y[0]] = y[1].to_f #adds product name and price to products hash
#       end
#     end #of x.each do
#     @@all_online_orders << Grocery::Order.new(id, products) #initalizes a new order using the id and products hash for the current line and adds it to all orders array
#     products = {} #clears the products array for the next order.
#   end #of CSV line by line
#   return @@all_online_orders
# end
# x = OnlineOrder.new(19, {cheese:5.00, bacon:5.00}, Grocery::Customer.new(12, "amy@this.com", "123 Fake St., Dayton, Ohio, 12121"), :pending)
# puts x.customer_id
# puts x.products
# puts x.inspect
# puts x.total
#puts x.total
# A customer object
# A fulfillment status (stored as a Symbol)
# pending, paid, processing, shipped or complete
# If no status is provided, it should set to pending as the default
