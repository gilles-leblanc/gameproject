require 'test/unit'
require 'mocha/setup'
require_relative '../inn_event'

# Tests on the inn event class.
class TestInnEvent < Test::Unit::TestCase
  def test_returns_greeting_string_with_inn_name
    inn_event = InnEvent.new('TestInnName')
    inn_event.expects(:puts).with('Inn: Welcome to TestInnName.')
    inn_event.act
  end
end