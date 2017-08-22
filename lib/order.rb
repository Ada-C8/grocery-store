module Grocery
  PRODUCT = {tomato: 3.49, pear: 2.49, rice: 1.50, beans: 4.00}
  ### Don't forget to commit
  class Order
    attr_reader :id, :products

    def initialize(id, products)
      @id = id
      @id.is_a? Integer
      @products = products
      @products.length == 0
    end

    # def total
    #   sum = 0
    #   # expected_total = 0
    #   # products.each do|item,cost|
    #   # sum = products.cost.map(&:last).reduce(:+)
    #   # @products.inject(0) |item, cost|
    #   #   sum += cost.last
    #
    #     #inject(0) is the initial value of total.
    #   # expected_total = sum + (sum * 0.075).round(2)
    #   products.each do |item, cost|
    #     sum += value.last.to_f
    #     # expected_total = sum + (sum * 0.075).round(2)
    #   end



    #   end
    #
    #
    #   def add_product(product_name, product_price)
    #     # TODO: implement add_product
    #   end
  end
end
