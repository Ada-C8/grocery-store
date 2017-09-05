# specs/spec_helper.rb
require 'minitest'
require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/pride'

require 'simplecov'
SimpleCov.start

# Require any classes
require_relative '../lib/order'
require_relative '../lib/online_order'
require_relative '../lib/customer'

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new
