require_relative '../broadcast'

class GuildEvent
  include Broadcast

  def initialize(guildName)
    @guildName = guildName
  end

  def act
    broadcast "Guild: Welcome to #{@guildName}."

  end
end