require_relative '../map'
require_relative 'city_factory'
require_relative '../Events/shop_event'
require_relative '../Events/inn_event'
require_relative '../Events/guild_event'
require_relative '../Events/temple_event'

# A reasonable sized city for most worlds.
class SmallCityFactory < CityFactory
  def initialize
    super
    @width = 24
    @height = 24
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

    events = [ShopEvent.new(establishment_name_generator.get_shop_name),
              InnEvent.new(establishment_name_generator.get_tavern_name),
              TempleEvent.new(temple_name_generator.get_name),
              GuildEvent.new(establishment_name_generator.get_name)]

    place_events(events)

    @city
  end
end