require 'csv'
require 'pry'
require 'awesome_print'

module Grocery

  class Customer

    attr_reader :id, :email, :address_1, :city, :state, :zip, :all_customers

    def initialize(id, email, address_1, city, state, zip)
      @id = id
      @email = email
      @address_1 = address_1
      @city = city
      @state = state
      @zip = zip
    end


    def self.all(file_name)
      @all_customers = []
      CSV.open(file_name, "r").each do |row|
        @id = row[0].to_i
        @email = row[1]
        @address_1 = row[2]
        @city = row[3]
        @state = row[4]
        @zip = row[5]
        # @each_customer = { id: @id, email: @email, address_1: @address_1, city: @city, zip: @zip}
        @all_customers << Grocery::Customer.new(@id, @email, @address_1, @city, @state, @zip)
      end
      return @all_customers
    end

    def self.find(file_name, id)
      self.all(file_name).each do |instance|
        if instance.id == id
          return instance
        end
      end
      raise ArgumentError.new "Invalid Customer Number"
    end


  end

end
