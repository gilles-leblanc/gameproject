require_relative '../map'
require_relative 'city_factory'

class TestCityFactory < CityFactory
  def initialize
    @width = 20
    @height = 20
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

    city
  end
end