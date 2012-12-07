require 'gosu'
require 'texplay'
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
		case map.tile_at(current_position[:x], current_position[:y]).type
		when :water  
			tile_to_draw = @water_tile
		when :grass
				tile_to_draw = @grass_tile
		when :sand
				tile_to_draw = @sand_tile
		when :forest
				tile_to_draw = @forest_tile
		else
				tile_to_draw = @mountain_tile	
		end
		
		tile_to_draw.draw(@left, @top, 0)
	end
end
