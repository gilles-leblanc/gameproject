require_relative './world_map'
require_relative './gaussian_filter'
require_relative './river_filter'
require_relative './height_map_configurator'
require_relative '../City/small_city_factory'
require_relative '../Maze/dungeon_factory'

# Can make maps by running all the necessary steps in order.
class MapFactory
  def self.make(x, y, height_map_config = HeightMapConfigurator::Sample_config_1,
      rain_map_config = HeightMapConfigurator::RainMap_small_world)

    height_map = HeightMap.new
    height_map.visit(height_map_config)
    height_map.generate(x, y)

    blur_filter = GaussianFilter.new
    blur_filtered = height_map.filter(blur_filter)

    river_filter = RiverFilter.new(x, y, rain_map_config)
    river_filtered = blur_filtered.filter(river_filter)

    city_factory = SmallCityFactory.new
    dungeon_factory = DungeonFactory.new
    WorldMap.new(x, y, river_filtered.data, city_factory, dungeon_factory)
  end

  def self.make_small_world
    self.make(50, 50, HeightMapConfigurator::Small_world, HeightMapConfigurator::RainMap_small_world)
  end
end
