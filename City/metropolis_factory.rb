require_relative '../map'
require_relative 'city_factory'

class MetropolisFactory < CityFactory
  def initialize
    @width = 80
    @height = 80
    @tiles = Array.new
  end

  def build
    initialize_starting_tiles
    place_entrance
    readjust_walls

    city = Map.new(@width, @height, @tiles)
    city.name = give_name

    place_buildings(city)
    #place_dead_ends(city)  # bug on place_dead_ends for city large than about 40+

    city
  end
end