require 'csv'
require 'pry'
require 'awesome_print'
require_relative 'order.rb'
require_relative 'customer.rb'

module Grocery
  class OnlineOrder < Order

    attr_reader :id, :all_online_orders, :status, :customer_id, :customer_object

    attr_accessor :food_and_price

    def initialize(id, food_and_price, customer_id, customer_object, status)
      super(id, food_and_price)
      @customer_id = customer_id
      @customer_object = Grocery::Customer.find("./support/customers.csv", customer_id)
      if status == nil
        @status = :pending
      else
        @status = status
      end
    end

    def self.all(file_name)
      @all_online_orders = []
      CSV.open(file_name, "r").each do |row|
        @food_and_price = {}
        @id = row[0].to_i
        @customer_id = row[2].to_i
        # puts @customer_id
        @status = row[3].to_sym
        @items = row[1].split(";")
        @items.each do |sep|
          food_price_array = sep.split(":")
          # puts food_and_price_array
          @food_and_price[food_price_array[0].to_s] = food_price_array[1].to_f
        end
        @customer_object = Grocery::Customer.find("./support/customers.csv", @customer_id)
        @all_online_orders << Grocery::OnlineOrder.new(@id, @food_and_price, @customer_id, @customer_object, @status)
      end
      return @all_online_orders
    end

    def self.find(file_name, id)
      self.all(file_name).each do |instance|
        if instance.id == id
          return instance
        end
      end
      raise ArgumentError.new "Invalid Order Number"
    end


    def self.find_by_customer(file_name, customer_id)
      list_by_customer = []
      self.all(file_name).each do |instance|
        if instance.customer_id == customer_id
          list_by_customer << instance
        end
      end
      return list_by_customer
    end

    def total
      if !(food_and_price.empty?)
        super + 10
      else
        return 0
      end
    end

    def add_product(product, price)
      if status == :pending || status == :paid
        @food_and_price[product] = price
      else
        raise ArgumentError.new "Too late to add items"
      end
    end

  end

end
