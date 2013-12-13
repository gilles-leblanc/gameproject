require_relative '../broadcast'

# The event that happens when the party enters an inn building in a city.
class InnEvent
  include Broadcast

  def initialize(inn_name)
    @inn_name = inn_name
  end

  def act
    broadcast "Inn: Welcome to #{@inn_name}."

  end
end