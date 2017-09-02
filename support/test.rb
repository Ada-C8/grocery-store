orders = []
require 'csv'
CSV.open("orders.csv", 'r').each do |line|
  orders << Order.new(line[0], line[1])
end
puts orders
