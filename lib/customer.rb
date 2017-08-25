module Grocery
class Customer
  attr_reader :id, :email, :address

  @@c_imported = false

  def self.all
    @@all_customers = Array.new
    if @@c_imported == false

      CSV.read('support/customers.csv').each do |row|
        id = row[0]
        email = row[1]
        address = row[2..-1]
        @@all_customers << Customer.new(id, email, address)
        end

      @@c_imported == true
    end

    return @@all_customers
  end

  def self.find(id)
    if @@all_customers[id] == nil
      raise ArgumentError.new ("Customer does not exist")
    else
      return @@all_customers[id]
    end
  end

  def initialize(id, email, address)
    @id = id
    @email = email
    @address = address
  end

end # Customer Class
end # Grocery module
