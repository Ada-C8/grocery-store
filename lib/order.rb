module Grocery
  class Order
    attr_reader :id, :products

    def initialize(id, products)
      @id = id
      @products = products
    end

    def total
      # TODO: implement total
      total = 0
      products.each do |name, price|
        total += price + (price *0.075)
      end
       return total.round(2)
    end


    def add_product(product_name, product_price)
      # TODO: implement add_product
    end
  end
end


#
#
# inventory = {
#   "apple" => 1.0,
#   "tomato_soup" => 2.0,
#   "milk" => 2.50,
# "chicken" => 5.75
# }
#
# t = Grocery::Order.new(1, inventory)
# puts t.total
#
# puts t.products
