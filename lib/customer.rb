require_relative "order.rb"

module Grocery
  class Customer
    # class Grocery::Customer
    # include Grocery


    attr_reader :id, :email, :address
    def initialize(id, email, address)
      @id = id
      @email = email
      @address = address
    end

    def self.all
      customers = []
      # data = []
      CSV.open("support/customers.csv", "r").each do |line|
        #  {line[0].to_i => [line[1], line[2..5].join(", ") ]}
        customers << Grocery::Customer.new(line[0].to_i, line[1], line[2..5].join(", ") )
      end
      return customers
    end

    def self.find(id)
      customers = Grocery::Customer.all
      if id > customers.length || id <= 0
        raise ArgumentError.new('Invalid ID.')
      else
        return customers[id-1]
      end
    end

  end
end

# puts Grocery::Customer.find(1).email
  # puts Grocery::Customer.all
  # puts Grocery::Customer.all
  # puts Customer.all.length
