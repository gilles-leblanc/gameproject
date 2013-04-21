require_relative '../map'
require_relative 'city_factory'

class SmallCityFactory < CityFactory
  def initialize
    super
    @width = 24
    @height = 24
    @tiles = Array.new
  end

  def build
    initialize_starting_tiles
    place_entrance
    readjust_walls

    city = Map.new(@width, @height, @tiles)
    city.name = give_name

    place_buildings(city)
    place_dead_ends(city)
    place_events(city)

    city
  end
end