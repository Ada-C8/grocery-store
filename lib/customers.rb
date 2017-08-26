require 'csv'


class Customer
  attr_reader :id, :email, :address_1, :city, :state, :zip_code

  def initialize(id, email, address_1, city, state, zip_code)
    @id = id
    @email = email
    @address_1 = address_1
    @city = city
    @state = state
    @zip_code = zip_code
  end

  # def new_customer
  #   return @id, @email, @address_1, @city, @state, @zip_code
  # end

  def self.all
    all = []
    customers = []
    CSV.open("../support/customers.csv", "r", converters: :numeric).each do |row|
      id = row[0]
      email = row[1]
      address_1 = row[2]#row[2..-1].join(", ")
      city = row[3]
      state = row[4]
      zip_code = row[5]
      customers_info = [id, email, address_1, city, state, zip_code]
      customers << customers_info
    end
    all << customers

    all_instances = []
    all[0].each do |id, email, address_1, city, state, zip_code|
      customer_instance = Customer.new(id, email, address_1, city, state, zip_code)
      all_instances << customer_instance
    end

    return all_instances
  end

  def self.find(id)
    all
    if id > 0 && id <= all.length
      return all[id - 1]
    else
      return "Sorry, that customer doesn't exist"
    end
  end

end
