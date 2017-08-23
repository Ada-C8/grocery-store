module Grocery
  class Customer
    attr_reader :id, :email, :address, :array_of_customers

    def initialize(id,email,address)
      @id = id
      @email = email
      @address = address
    end

    def self.all(csv_file)
      array_of_customers = []
      csv_file.length.times do |i|
        csv_line = csv_file[i]
        id = csv_line[0].to_i
        email = csv_line[1]
        address = {}
        address[:address_line] = csv_line[2]
        address[:city] = csv_line[3]
        address[:state] = csv_line[4]
        address[:zip_code] = csv_line[5]
        array_of_customers << self.new(id, email,address)
      end
      return array_of_customers
    end

    def self.find(csv_file,id_lookup)
      customer_to_return = nil
      array_of_customers = self.all(csv_file)
      array_of_customers.each do |customer|
        if customer.id == id_lookup
          customer_to_return = customer
        end
      end
      if customer_to_return.nil?
        raise ArgumentError.new "No customer with that Id #"
      end
      return customer_to_return
    end

  end # end class
end #end module
