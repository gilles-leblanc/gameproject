require_relative '../map'
require_relative 'city_factory'

class OutpostFactory < CityFactory
  def initialize
    super
    @width = 12
    @height = 12
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