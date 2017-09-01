
module Grocery
  class Customer

    attr_reader :id, :email, :address

    def initialize(id, email, street, city, state, zip)
      @id = id.to_i
      @email = email
      @address = {street: street, city: city, state: state, zip: zip}
    end

    def self.all(filename)
      all_customers = []
      CSV.open(filename).each do |customer|
        id, email, street, city, state, zip = customer
        all_customers << Customer.new(id, email, street, city, state, zip)
      end
      return all_customers
    end

    def self.find(id, list)
      list.each do |customer|
        if customer.id == id
          return customer
        end
      end
      raise RangeError.new("ID does not exist: #{id}")
    end

  end # end of Customer class definition
end
