class Customer
  attr_reader :id, :email, :address


  def initialize(id, email, address)
    @id = id
    @email = email
    @address = address
  end

  def self.all
    customers = []
    return customers
  end

  def self.find
  end


end
