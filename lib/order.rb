module Grocery
  class Order
    attr_reader :id, :products

    def initialize(id, collection)
      @id = id
      @products = collection
    end

    def total
      cost = 0
      @products.each do |item, price|
        cost += @products[item]
      end
      return (cost * 1.075).round(2)
    end

    def add_product(product_name, product_price)
      if @products.include?(product_name)
        return false
      else
        @products[product_name] = product_price
        return true
      end
    end

    def remove_product(name)
      if @products.include?(name)
        @products[name].delete
        return true
      else
        return false
      end
    end
  end
end
