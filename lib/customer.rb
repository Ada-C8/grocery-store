require_relative 'order'
require 'csv'

module Grocery
  class Customer
    attr_accessor :id, :email, :delivery_address
    @@customers = []
    def initialize(id, email, delivery_address)
      @id = id.to_i
      @email = email
      @delivery_address = delivery_address
    end

    def self.all
      if @@customers.any?
        return @@customers
      end

      CSV.open("./support/customers.csv", "r",
      headers: true).each do |customer|
        address = "#{customer["address1"]}\n#{customer["city"]}, #{customer["state"]} #{customer["zip"]}"

        @@customers.push(Customer.new(customer["id"], customer["email"], address))
      end
      return @@customers
    end

    def self.find(id_input)
      if @@customers.empty?
        all
      end

      if id_input > all.length
        raise ArgumentError.new("That customer doesn't exist")
      end

      @@customers.each do |customer|
        if customer.id == id_input
          return customer
        end
      end
    end



  end

end

puts Grocery::Customer.find(1)
