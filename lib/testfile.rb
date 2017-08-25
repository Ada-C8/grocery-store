require 'csv'


# CSV.open("../support/orders.csv", 'r').each do |line|
#     n = 0
#     count = line.length
#     line.count.times do |i|
#     unless line == line[i][0]
#       products = line[i][n].split(";")
#       orders << products
#     end
#     n += 1
#   end
# end

text = CSV.read("../support/orders.csv")

# orders = text[0][1].split(";")
# orders = text[0][1].gsub(':', ': ')
# print orders
# orders = []
# strings = []
# element = []
#
# orders.each do |string|
#   strings << line[1].split(";")
# end
#
# strings.each do |string|
#   string.each do |element|
#   element.split(":")
#   orders_array << element
#   end
#
# end


text = CSV.read("../support/orders.csv")

orders = []
text.each do |line|
orders << line[1].split(';')
end

product = nil

orders.each do |string|
  string.each do |element|
    element.split(':')
    product = element.split(':')
  end
  orders << product

end

print orders

#puts orders_array[0].slice(02)


# orders_array.each do
#   orders_array.split(":")
# orders_array.each do |i|
#   orders_array[i].gsub(":", "=>")
# end

# orders.each do |line|
#   #product_hash = {}
#   #orders_array << line[1].split(";")  #this way works...
#   products = [line[1].split(';')]
#   products.each do |index|
#     products = products[index].split(':')
#   end
# orders_array << products
# end
  #prouct = product.gsub(':', ', ')
  #orders_array << product
  # product = line[1].split(";")
  # product = product.gsub(':', ': ')
  #
  # prodcut_hash << product
  # orders << product_hash



#print orders_array
