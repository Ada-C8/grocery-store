require_relative 'order'
require 'csv'

module Grocery
  class Customer
    attr_accessor :id, :email, :delivery_address, :customers
    @@customers = []
    def initialize(id, email, delivery_address)
      @id = id
      @email = email
      @delivery_address = delivery_address
    end

    def self.valid_id(id)
      if id.class != Integer
        raise ArgumentError.new("Please enter a valid Integer ID")
      elsif id <= 0 || id > all.length
        raise ArgumentError.new("That ID doesn't exist.")
      end
    end

    def self.all
      if @@customers.any?
        return @@customers
      end

      CSV.open("./support/customers.csv", "r",
      headers: true).each do |customer|
        id = customer["id"].to_i
        address = "#{customer["address1"]}\n#{customer["city"]}, #{customer["state"]} #{customer["zip"]}"

        @@customers.push(Customer.new(id, customer["email"], address))
      end
      return @@customers
    end

    def self.find(id_input)
      valid_id(id_input)
      if @@customers.empty?
        all
      end

      @@customers.each do |customer|
        if customer.id == id_input
          return customer
        end
      end
    end
  end
end
