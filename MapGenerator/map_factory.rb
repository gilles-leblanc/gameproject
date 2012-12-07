require_relative './world_map'
require_relative './gaussian_filter'
require_relative './height_map_configurator'

class MapFactory
	def self.make(x, y)
		height_map = HeightMap.new
		height_map.visit(HeightMapConfigurator::Sample_config_1)
		height_map.generate(x, y)
	
		blur_filter = GaussianFilter.new
	
		WorldMap.new(x, y, height_map.filter(blur_filter).data)		
	end
end
