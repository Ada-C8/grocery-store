require_relative "order.rb"

class Grocery::Customer

  attr_reader :id, :email, :address
  def initialize(id, email, address)
    @id = id
    @email = email
    @address = address
  end

  # def self.all
  #   orders = []
  #   data = []
  #   CSV.open("support/orders.csv", "r").each do |line|
  #     # @orders[line[0]] =
  #     string = line[1..-1].join
  #     product_data = string.split(/:|;/)
  #     product_data.each_with_index do |datum, i|
  #       if i % 2 == 0
  #         data << datum.to_s
  #       elsif i % 2 == 1
  #         data << datum.to_f
  #       end
  #     end
  #     order = Grocery::Order.new(line[0].to_i, Hash[*data])
  #     orders.push(order)
  #   end
  #   return orders
  # end
  #
  # def find.all
  #   orders = Grocery::Order.all
  #   if id > orders.length || id <=0
  #     raise ArgumentError.new('Invalid ID.')
  #   else
  #     return orders[id-1]
  #   end
  # end

end
