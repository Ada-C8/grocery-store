# online_order

module Grocery
  class OnlineOrder < Order
    attr_reader :id, :products, :orders

    def initialize()
      @customer = customer
      @products = products
      @customer_id = customer_id
      @status = status


      def self.all
        @orders = {}
        CSV.open('/Users/Marisa/documents/ada developers academy/projects/grocery-store/support/online_orders.csv', 'r').each do |id,items|
          @orders[id.to_i] = items.split(";").map do |item|
            array = item.split(":")
            {array[0] => array[1]}
          # puts orders
          end
        end
      end #self.all method end


      def self.find(id)
        # raised argument error if order ID number is greater than 100.
        if id > 100
          raise ArgumentError.new("You messed up!")
        end
        # looks into all order IDs and returns the ones in the ones .find is called on.
        return @orders[id]
      end #self.find method end


      def self.find_by_customer(id)
      end


      def total
        #inheritance - update so it adds the tax on to the total
        super + 10
        # sum = @products.values.inject(0, :+)
        # expected_total = sum + (sum * 0.075).round(2)

      end #total method end

    end #initialize end
  end #class end
end #module end
