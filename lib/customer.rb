require 'csv'

module Grocery
  class Customer

    attr_reader :id, :email, :address

    def initialize(id, email, address)
      @id = id
      @email = email
      @address = address
    end

    def self.customer_from_line(csv_line)
      return Grocery::Customer.new(csv_line[0].to_i, csv_line[1], "#{csv_line[2]}, #{csv_line[3]}, #{csv_line[4]}, #{csv_line[5]}")
    end

    def self.all(file = "support/customers.csv")
      customers = []
      CSV.open(file, "r").each do |line|
        customers << self.customer_from_line(line)
      end
      return customers
    end

    def self.find(id, file = "support/customers.csv")
      CSV.open(file, "r").each do |line|
        if line[0] == id.to_s
          return self.customer_from_line(line)
        end
      end
      raise KeyError.new("ID not found")
    end
    

  end #end of class Customer
end #end of module Grocery
