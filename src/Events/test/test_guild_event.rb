require 'test/unit'
require 'mocha/setup'
require_relative '../guild_event'

# Tests on the guild event class.
class TestGuildEvent < Test::Unit::TestCase
  def test_returns_greeting_string_with_guild_name
    guild_event = GuildEvent.new('TestGuildName')
    guild_event.expects(:puts).with('Guild: Welcome to TestGuildName.')
    guild_event.act
  end
end