require_relative '../map'
require_relative 'city_factory'
require_relative '../Events/shop_event'
require_relative '../Events/inn_event'
require_relative '../Events/guild_event'
require_relative '../Events/temple_event'

# Used in conjunction with city_map_output for testing during development.
class TestCityFactory < CityFactory
  def initialize
    super
    @width = 20
    @height = 20
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

    @city
  end
end