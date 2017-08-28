module Grocery
class Customer
  attr_reader :id, :email, :address


  def self.all
    all_customers = Array.new

      CSV.read('support/customers.csv').each do |row|
        id = row[0]
        email = row[1]
        address = row[2..-1]
        all_customers << Customer.new(id, email, address)
        end

    return all_customers
  end

  def self.find(id)
    all_customers = self.all
    if all_customers[id] == nil
      raise ArgumentError.new ("Customer does not exist")
    else
      return all_customers[id]
    end
  end

  def initialize(id, email, address)
    @id = id
    @email = email
    @address = address
  end

end # Customer Class
end # Grocery module
