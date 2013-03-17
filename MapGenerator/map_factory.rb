require_relative './world_map'
require_relative './gaussian_filter'
require_relative './river_filter'
require_relative './height_map_configurator'

class MapFactory
	def self.make(x, y)
		height_map = HeightMap.new
		height_map.visit(HeightMapConfigurator::Sample_config_1)
		height_map.generate(x, y)
	
		blur_filter = GaussianFilter.new
    blur_filtered = height_map.filter(blur_filter)

    river_filter = RiverFilter.new(x, y)
    river_filtered = blur_filtered.filter(river_filter)

		WorldMap.new(x, y, river_filtered.data)
  end

  def self.make_small_world
    height_map = HeightMap.new
    height_map.visit(HeightMapConfigurator::Small_world)

    height_map.generate(50, 50)

    blur_filter = GaussianFilter.new
    blur_filtered = height_map.filter(blur_filter).filter(blur_filter)

    # TODO: add river filter (not included for speed during testing of map_explorer)

    WorldMap.new(50, 50, blur_filtered.data)
  end
end
