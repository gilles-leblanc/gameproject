require_relative '../map'
require_relative 'city_factory'
require_relative '../Events/shop_event'
require_relative '../Events/inn_event'
require_relative '../Events/guild_event'
require_relative '../Events/temple_event'

# The smallest city factory available. This will typically have between
# 2 and 4 buildings.
class OutpostFactory < CityFactory
  def initialize
    super
    @width = 12
    @height = 12
    @tiles = []
  end

  def build
    initialize_starting_tiles
    place_entrance
    readjust_walls

    @city = Map.new(@width, @height, @tiles)
    @city.name = give_name

    place_buildings
    place_dead_ends

    events = [InnEvent.new(establishment_name_generator.get_tavern_name)]

    place_events(events)

    @city
  end
end