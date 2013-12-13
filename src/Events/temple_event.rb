require_relative '../broadcast'

# The event that happens when the party enters a temple building in a city.
class TempleEvent
  include Broadcast

  def initialize(temple_name)
    @temple_name = temple_name
  end

  def act
    broadcast "Temple: Welcome to #{@temple_name}."

  end
end