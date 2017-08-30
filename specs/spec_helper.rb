# specs/spec_helper.rb
require 'simplecov'
SimpleCov.start

require 'minitest'
require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/pride'

# Require any classes
# ex require_relative 'lib/foo.rb'
require_relative '../lib/order'
require_relative '../lib/online_order'
require 'csv'
require_relative '../lib/customer'

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new
