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

def initalize
  @customer = customer
  @status = :pending
end #init

def total
  @total = super + 10.00
  return  @total
end #total method

end #class

x = OnlineOrder.new(19, {cheese:5.00, bacon:5.00})
puts x.id
puts x.products
puts x.total
# A customer object
# A fulfillment status (stored as a Symbol)
# pending, paid, processing, shipped or complete
# If no status is provided, it should set to pending as the default
