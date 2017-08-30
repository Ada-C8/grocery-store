require 'simplecov'
SimpleCov.start


require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/order'
require_relative '../lib/online_order'
require_relative '../lib/customer'


Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new
