module Grocery
  class Order
    attr_reader :id, :products

    def initialize(id, products)
      #raise argument error if id or order is a negative number

      if id < 1
        raise ArgumentError.new("Invalid id: #{id}")
      end

      # if products != {}
      #   raise ArgumentError.new("Invalid product(s): #{products}")
      # end

      @id = id
      @products = products
      # a collection of products and their cost
      # zero products is permitted
      # you can assume that there is only one of each product
    end

    # calculate the total cost of the order by:
    # summing up the products
    # adding a 7.5% tax
    # ensure the result is rounded to two decimal places
    def total
      add_products = 0
      @products.each_value do |cost|
        add_products += cost
      end
      total = (add_products + (add_products * 0.075)).round(2)
      return total
    end

    # take in two parameters, product name and price, and add the data to the product collection
    # It should return true if the item was successfully added and false if it was not
    def add_product(product_name, product_price)
      # pair_present?(hash_name,'key', value)
      if @products.key?(product_name) == true
        return false
      else
        @products[product_name] = product_price
        return true
      end
    end

    # Add a remove_product method to the Order class which will take in one parameter, a product name, and remove the product from the collection
    # It should return true if the item was successfully remove and false if it was not

    def remove_product(product_name)
      if @products.key?(product_name) == true
        @products.delete(product_name)
        return true
      else
        return false
      end
    end

  end#Order
end
