require 'csv'
require 'awesome_print'


# Reads the contents of the file into an array of arrays.
# CSV.open('/Users/Marisa/documents/ada developers academy/projects/grocery-store/support/orders.csv', 'r').each do |row|
#   puts row
# end

orders = {}
CSV.open('/Users/Marisa/documents/ada developers academy/projects/grocery-store/support/orders.csv', 'r').each do |rows|
  # orders[rows[0]] = [rows[1]].split(";")
  puts orders
end




# csv loop
# split productss
# split name and price


# tests
# it gives products
# order number is right
#
# right name/price
# number orders is correct
# test first and last order
