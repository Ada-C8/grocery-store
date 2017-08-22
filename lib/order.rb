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
    end

    def add_product(product_name, product_price)
      @products[product_name] = product_price
    end



  end # end of class
end # module
