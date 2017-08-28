require 'csv'

module Grocery
  class Order
    attr_reader :id, :products

    #@@allordersnumber = 0
    #@@allorders = []

    def initialize(id, products)
      @id = id
      @products = products
      #@allorders = []
      #@@allordersnumber += 1
      #@@allorders << self
    end


    def total
      without_taxes = 0
      @products.each do |product, value|
        without_taxes += value
      end
      total_price = without_taxes + ( without_taxes * 0.075)
      return total_price.round(2)
    end

    def add_product(product_name, product_price)
      if @products.key?(product_name)
        return false
      else
        @products[product_name] = product_price
        return true
      end
    end

    def delete_product(product_name)
      if @products.key?(product_name)
        @products.delete(product_name)
        return true
      else
        return false
      end
    end

    def see
      return @products
    end

    def self.all
      csv_order = {}
      allorders = []

      CSV.open('support/orders.csv', "r").each do |row|
        csv_order[row[0].to_i] = row[1]
      end


      temp={}
      csv_order.each do |k ,v|
        temp[k] = v.split(";")
      end

      csv_order = temp

      temp1 = {}
      csv_order.each do |k,v|
        hash_product = {}
        v.each do |s|
          array = s.split(":")
          hash_product[array[0]] = array[1].to_f
        end
        temp1[k] = hash_product
      end

      csv_order = temp1

      csv_order.each do |id, o|
        allorders << Grocery::Order.new(id,o)
      end
      return allorders
    end

    def self.find(id)
      self.all.each do |oneorder|
        if oneorder.id == id
          return  oneorder.products
        end
      end
      raise ArgumentError.new("Non existing ID: #{id}")
    end

  end
end


# csvorders = Grocery::Order.all
# print csvorders
#puts Grocery::Order.find(1)



# csv_order = {}
#
# CSV.open('support/orders.csv').each do |row|
#   csv_order[row[0]] = row[1]
# end
#
#
# temp={}
# csv_order.each do |k ,v|
#   temp[k] = v.split(";")
# end
#
# csv_order = temp
#
# temp1 = {}
# csv_order.each do |k,v|
#   hash_product = {}
#   v.each do |s|
#     array = s.split(":")
#     hash_product[array[0]] = array[1].to_f
#   end
#   temp1[k] = hash_product
# end
#
# csv_order = temp1

#csv_order.each do |id, o|
#  Grocery::Order.new(id,o)
#end




#puts Grocery::Order.find("200")


#puts from_csv[0][1]
# products = {cream: 2.34, soup: 1.50, water: 2.25 }
# id = 4
#
#
# example = Grocery::Order.new(id,products)
# example.delete_product(:soup)
# puts example.see

#puts Grocery::Order.all
