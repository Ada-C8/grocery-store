require 'csv'
require_relative 'order'
require_relative 'customers'

module Grocery
  class OnlineOrder < Order
    @@csv = "../support/online_orders.csv"

    def initialize
      @customer = "fail"
      @status = "fail"
    end

    def self.all
      super
    end

  end
end

# id = 1337
# products = { "banana" => 1.99, "cracker" => 3.00, "sandwich" => 4.25 }
# online_order = Grocery::Order.new(id,products)
# puts online_order.class

p "I'm an OnlineOrder"
p Grocery::OnlineOrder.find(3)
