require_relative 'order'
require 'csv'

# inherit behavior from the Order class and include additional data to track the customer and order status.
module Grocery
  class OnlineOrder < Grocery::Order
  end
end
