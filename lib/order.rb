module Grocery
  ### Don't forget to commit
  class Order
    attr_reader :id, :products

    def initialize(id, products)
      @id = id
      @id.is_a? Integer
      @products = products
      @products.length == 0
    end

    def total
      sum = 0
      products.each do |item, cost|
        sum = (sum + cost)
      end
        total = ((sum * 0.075) + sum).round(2)

      # expected_total = 0
      # products.each do|item,cost|
      # sum = products.cost.map(&:last).reduce(:+)
      # @products.inject(0) |item, cost|
      #   sum += cost.last

      #inject(0) is the initial value of total.
      # expected_total = sum + (sum * 0.075).round(2)

      # expected_total = sum + (sum * 0.075).round(2)
    end



    #   end
    #
    #
    #   def add_product(product_name, product_price)
    #     # TODO: implement add_product
    #   end
  end # end of class
end # module
