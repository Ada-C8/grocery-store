module Grocery
  class Order
    attr_reader :id, :products

    def initialize(id, products)
      @id = id
      @products = products
    end

    def total
      total = 0
      products.each do |name, price|
        total += price + (price * 0.075)
      end
      return total.round(2)
    end


    def add_product(product_name, product_price)
      # TODO: implement add_product
      if @products.key?(product_name)
        return false
      else
        @products[product_name] = product_price
        return true
      end
    end

  end #end  class Order
end# end module Grocery


#
