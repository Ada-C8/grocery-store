require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'


require_relative '../lib/online_order'#online_order
require_relative '../lib/order'
require_relative '../lib/costumer'



# Because an OnlineOrder is a kind of Order, and we've
# already tested a bunch of functionality on Order,
# we effectively get all that testing for free! Here we'll
# only test things that are different.

describe "OnlineOrder" do
  describe "#initialize" do
    it "Is a kind of Order" do
      # Check that an OnlineOrder is in fact a kind of Order

      # Instatiate your OnlineOrder here
      idc = 123
      email = "bartsimpson@gmail.com"
      costumer =  Grocery::Costumer.new(idc, email, {})
      ido = 199
      online_order = Grocery::OnlineOrder.new(ido, {}, costumer, :pending)
      online_order.must_be_kind_of Grocery::Order
    end

    it "Can access Customer object" do
      # TODO: Your test code here!
      idc = 123
      email = "bartsimpson@gmail.com"
      costumer =  Grocery::Costumer.new(idc, email, {})
      ido = 199
      online_order = Grocery::OnlineOrder.new(ido, {}, costumer, :pending)
      online_order.must_respond_to :costumer
    end

    it "Can access the online order status" do
      # TODO: Your test code here!
      idc = 123
      email = "bartsimpson@gmail.com"
      costumer =  Grocery::Costumer.new(idc, email, {})
      ido = 199
      online_order = Grocery::OnlineOrder.new(ido, {}, costumer, :pending)
      online_order.must_respond_to :status

    end
  end

  describe "#total" do
    it "Adds a shipping fee" do

      idc = 123
      email = "bartsimpson@gmail.com"
      address = {"Address 1" => "7513 Kaylee Summit" ,"City" => "Uptonhaven", "State" => "DE", "Zip-Code" => "64529-2614"}
      costumer =  Grocery::Costumer.new(idc, email, address)
      ido = 1
      products = { "banana" => 1.99, "cracker" => 3.00 }
      order = Grocery::Order.new(ido, products)
      online_order = Grocery::OnlineOrder.new(ido, products, costumer, :pending)
      online_order.total.must_equal(order.total + 10 )
    end

    it "Doesn't add a shipping fee if there are no products" do

      idc = 123
      email = "bartsimpson@gmail.com"
      address = {"Address 1" => "7513 Kaylee Summit" ,"City" => "Uptonhaven", "State" => "DE", "Zip-Code" => "64529-2614"}
      costumer =  Grocery::Costumer.new(idc, email, address)
      ido = 11
      products = {}
      order = Grocery::Order.new(ido, products)
      online_order = Grocery::OnlineOrder.new(ido, products, costumer, :pending)
      online_order.total.must_equal 0
    end
  end

  describe "#add_product" do
    it "Does not permit action for processing, shipped or completed statuses" do

      idc = 123
      email = "bartsimpson@gmail.com"
      address = {"Address 1" => "7513 Kaylee Summit" ,"City" => "Uptonhaven", "State" => "DE", "Zip-Code" => "64529-2614"}
      costumer =  Grocery::Costumer.new(idc, email, address)
      ido = 1
      products = { "banana" => 1.99, "cracker" => 3.00 }
      online_order1 = Grocery::OnlineOrder.new(ido, products, costumer, :processing)
      proc {online_order1.add_product("milk", 2.50).must_raise ArgumentError}
      online_order2 = Grocery::OnlineOrder.new(ido, products, costumer, :shipped)
      proc {online_order1.add_product("milk", 2.50).must_raise ArgumentError}
      online_order3 = Grocery::OnlineOrder.new(ido, products, costumer, :completed)
      proc {online_order3.add_product("milk", 2.50).must_raise ArgumentError}

    end

    it "Permits action for pending and paid satuses" do
      idc = 123
      email = "bartsimpson@gmail.com"
      address = {"Address 1" => "7513 Kaylee Summit" ,"City" => "Uptonhaven", "State" => "DE", "Zip-Code" => "64529-2614"}
      costumer =  Grocery::Costumer.new(idc, email, address)
      ido = 1
      products = { "banana" => 1.99, "cracker" => 3.00 }
      online_order1 = Grocery::OnlineOrder.new(ido, products, costumer, :pending)
      online_order1.add_product("eggs", 2.50).must_equal true
      online_order2 = Grocery::OnlineOrder.new(ido, products, costumer, :paid)
      online_order1.add_product("chocolate", 3.23).must_equal true

    end
  end

  describe "OnlineOrder.all" do
    it "Returns an array of all online orders" do
      # TODO: Your test code here!
      # Useful checks might include:
      #   - OnlineOrder.all returns an array
      everything = Grocery::Order.all
      everything.must_be_kind_of Array
      #   - Everything in the array is an Order
      everything.each do |oneorder|
        oneorder.must_be_kind_of Grocery::Order
      end
      #   - The number of orders is correct
      everything.length.must_equal 100
      #   - The customer is present
      #   - The status is present
      # Feel free to split this into multiple tests if needed
    end
  end

  describe "OnlineOrder.find_by_customer" do
    it "Returns an array of online orders for a specific customer ID" do
      # TODO: Your test code here!
    end
  end
end
