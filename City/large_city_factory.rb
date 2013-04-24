require_relative '../map'
require_relative 'city_factory'

class LargeCityFactory < CityFactory
  def initialize
    super
    @width = 32
    @height = 32
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

    events = [ShopEvent.new(@establishment_name_generator.get_shop_name),
              ShopEvent.new(@establishment_name_generator.get_shop_name),
              InnEvent.new(@establishment_name_generator.get_tavern_name),
              TempleEvent.new(@temple_name_generator.get_name),
              GuildEvent.new(@establishment_name_generator.get_name)]

    place_events(city, events)

    city
  end
end