require_relative '../broadcast'

# The event that happens when the party enters a guild building in a city.
class GuildEvent
  include Broadcast

  def initialize(guild_name)
    @guild_name = guild_name
  end

  def act
    broadcast "Guild: Welcome to #{@guild_name}."

  end
end