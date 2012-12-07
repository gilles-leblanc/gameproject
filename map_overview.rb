require 'gosu'
require_relative './color_palette'

class MapOverview
	def initialize(top, left, parent_window)
		@top = top
		@left = left
		
		@water_tile = Gosu::Image.new(parent_window, "media/water.png", true)   
    @grass_tile = Gosu::Image.new(parent_window, "media/grass.png", true)
    @mountain_tile = Gosu::Image.new(parent_window, "media/mountain.png", true)
    @sand_tile = Gosu::Image.new(parent_window, "media/sand.png", true)
    @forest_tile = Gosu::Image.new(parent_window, "media/forest.png", true)
	end

	def draw(map, current_position)
		map.tile_at(@current_position[:x], @current_position[:y])
	end
end
