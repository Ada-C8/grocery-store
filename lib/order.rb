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
      products.each {|name, price| total += price}
      total = total + (total* 0.075).round(2)
    end

    def add_product(product_name, product_price)
      # TODO: implement add_product
      if !@products.has_key? product_name
        @products[product_name] = product_price
        true
      else
        false
      end
    end

    def remove_product(product_name)
      @products.delete product_name
    end

    def product_keys
      @products.keys
    end

    def self.all
    end


  end

end
