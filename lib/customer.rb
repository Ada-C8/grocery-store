require_relative './online_order'

module Grocery
  class Customer
    attr_reader :id, :email, :address, :city, :state, :zip

    def initialize(id, email, address, city, state, zip_code)
      @id = id.to_i
      @email = email
      @address = address
      @city = city
      @state = state
      @zip = zip_code.to_i
    end

    def self.all
      customers = []
      CSV.open('./support/customers.csv', "r", headers: true).each do |row|
        customers << Customer.new(row["customer_id"], row["email"], row["address_1"], row["city"], row["state"], row["zip_code"])
      end
      customers
    end

    def self.find(id_num)
      customers = Customer.all
      ids = []
      customers.each do |customer|
        ids << customer.id
        return customer if customer.id == id_num
      end
      if !(ids.include?(id_num))
        return "Invalid Customer Number"
      end
    end
  end
end
