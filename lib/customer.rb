require 'csv'


module Grocery

  class Customer

    @@all_customers = Array.new

    attr_reader :customer_id, :email, :delivery_address

    def initialize(id, email, delivery_address)
      @customer_id = id.to_i
      @email = email
      @delivery_address = delivery_address
    end

    def self.all

      @@all_customers = []

      CSV.open('../support/customers.csv', 'r').each do |line|
        line[0] = line[0].to_i
        line[2] = line[2] + ", " + line[3] + ", " + line[4] + ", " + line[5]
        line.delete_at(5)
        line.delete_at(4)
        line.delete_at(3)
        @@all_customers << Customer.new(line[0], line[1], line[2])
      end #csv each
      return @@all_customers
    end #self.all method

    def self.all_customers
      return @@all_customers
    end

    def self.find(id)
      customers = Grocery::Customer.all
      item_num = []

      customers.each do |item|
        item_num << item.customer_id
      end

      if item_num.include?(id)
        return customers[id - 1]
      else
        raise ArgumentError, "ID not found."
      end
    end# method def
  end #customer class
end #module
