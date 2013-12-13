require 'test/unit'
require 'mocha/setup'
require_relative '../shop_event'

# Tests on the shop event class.
class TestShopEvent < Test::Unit::TestCase
  def test_returns_greeting_string_with_shop_name
    shop_event = ShopEvent.new('TestShopName')
    shop_event.expects(:puts).with('Shop: Welcome to TestShopName.')
    shop_event.act
  end
end