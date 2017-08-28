require 'csv'
require_relative '../lib/costumer'
require_relative '../lib/order'

module Grocery
  class OnlineOrder < Grocery::Order
    attr_reader :costumer, :status, :id, :products

    def initialize(id, products, costumer, status) #= :pending)
      @costumer = costumer
      @status = status
      #I have to initialize the products??
      @products = products
    end

    def total
      if super == 0
        return super
      else
        return super + 10
      end
    end

    def add_product(price, name)
      case @status
      when :processing || :shipped || :completed
        raise ArgumentError.new ("It is no possible to add items")
      when :pending || :paid
        return super
      end
    end

    def self.all
      totalorders = []
      CSV.open('support/online_orders.csv', "r").each do |order|
        idorder = order[0].to_i
        idperson = order[2].to_i
        status = order[3].to_sym
        products = order[1].split(";")
        hashproduct = {}
        products.each do |together|
          arrayproductprice = together.split(":")
          hashproduct[arrayproductprice[0]] = arrayproductprice[1].to_i
        end
        findcostumer = Grocery::Costumer.find(idperson)
        totalorders << Grocery::OnlineOrder.new(idorder, hashproduct, findcostumer, status)
      end
      return totalorders

    end




  end #class
 end #module
