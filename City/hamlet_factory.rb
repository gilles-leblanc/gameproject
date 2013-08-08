require_relative '../map'
require_relative 'city_factory'
require_relative '../Events/shop_event'
require_relative '../Events/inn_event'
require_relative '../Events/guild_event'
require_relative '../Events/temple_event'

# A city factory to generate a very small town with only 1 inn.
class HamletFactory < CityFactory
  def initialize
    super
    @width = 16
    @height = 16
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