require 'csv'

class Grocery::Customer
#class Customer
  attr_reader :id, :email, :address

  @@customers = []

  def initialize(id, email, address)
    @id = id
    @email = email
    @address = address
    @@customers.push(self)
  end

  def self.all
    return @@customers
  end

  def self.read(filename)
    @@customers = []
    CSV.foreach(filename) do |row|
      self.new(row[0].to_i, row[1], row[2..-1].join(","))
    end
  end

  def self.find(id)
    @@customers.each do |customer|
      return customer if customer.id == id
    end
    raise ArgumentError.new("This customer id does not exist")
  end

end
