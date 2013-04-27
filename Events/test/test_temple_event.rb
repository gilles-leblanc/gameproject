require 'test/unit'
require 'mocha/setup'
require_relative '../temple_event'

class TestTempleEvent < Test::Unit::TestCase
  def test_returns_greeting_string_with_temple_name
    temple_event = TempleEvent.new('TestTempleName')
    temple_event.expects(:puts).with('Temple: Welcome to TestTempleName.')
    temple_event.act
  end
end