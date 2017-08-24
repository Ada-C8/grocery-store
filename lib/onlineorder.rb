require_relative "order.rb"

class OnlineOrder < Grocery::Order



def total
  return super + 10
end

def add_product

  ## if status is pending or paid
  return super
  ## else raise ArgumentError
end

end
