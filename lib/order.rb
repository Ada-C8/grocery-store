module Grocery
  ### Don't forget to commit
  class Order
    attr_reader :id, :products

    def initialize(id, products)
      @id = id
      @products = products

    end

    def total
      sum = 0
      products.each do |item, cost|
        sum = (sum + cost)
      end
      total = ((sum * 0.075) + sum).round(2)
    end

    def add_product(product_name, product_price)
      if @products.include?(product_name)
        return false
      else
        @products[product_name] = product_price
        return true
      end

    end



  end # end of class
end # module
