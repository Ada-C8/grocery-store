require 'csv'
require_relative 'order.rb'
require_relative 'customers.rb'

module Grocery
  class OnlineOrder < Order

    def self.all
      super
    end

    # self.all modify order.rb if statment
    # if self == Grocery::Order
    # variable = this csv
    # elsif sellf == Grocery::OnlineOrder
    # variable = this csv
  end
end

puts Grocery::OnlineOrder.all
