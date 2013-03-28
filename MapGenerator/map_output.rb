# a simple way to output the various maps
# the reason for this file is to be able to view the maps during the 
# development of the map generator

require 'gosu'
require 'texplay'
require './world_map.rb'
require './gaussian_filter'
require './height_map_configurator'
require './river_filter'
require '../tile_palette'

class MapOutput < Gosu::Window
  def initialize
  	@x, @y = 80, 80
  
    super @x * 10, @y * 10, false
    self.caption = "Map Output"

    @height_map = HeightMap.new
		@height_map.visit(HeightMapConfigurator::Medium_world)
		@height_map.generate(@x, @y)
    
    blur_filter = GaussianFilter.new
		filtered_twice = @height_map.filter(blur_filter).filter(blur_filter)

    river_filter = RiverFilter.new(@x, @y)
    river_filtered = filtered_twice.filter(river_filter)

    @map = WorldMap.new(@x, @y, river_filtered.data)
    #@map = WorldMap.new(@x, @y, filtered_twice.data)

    @tile_palette = TilePalette.new(self, '.')
  end
  
  def update
  end
  
  def draw
  	font = Gosu::Font.new(self, Gosu::default_font_name, 20)
  
		@map.tiles.each do |tile|
      tile_to_draw = @tile_palette.get_tile_resource(tile)
			tile_to_draw.draw(tile.x * 10, tile.y * 10, 0)
      font.draw(@map.world_name, 10, 10, 0)
		end  
  end
  
  def button_down(id)
    if id == Gosu::KbEscape
      @height_map.draw("rendered_maps/unfiltered.png")
      
      blur_filter = GaussianFilter.new
			
			filtered_once = @height_map.filter(blur_filter)
			filtered_twice = @height_map.filter(blur_filter).filter(blur_filter)

			filtered_twice.draw("rendered_maps/filtered_twice.png")			
			filtered_once.draw("rendered_maps/filtered.png")
			
			@height_map.filter(blur_filter).draw("rendered_maps/filtered.png")
			@height_map.filter(blur_filter).filter(blur_filter).draw("rendered_maps/filtered_twice.png")
			
			image = TexPlay.create_image(self, @x, @y, :color => Gosu::Color::BLACK)
			image.draw(0, 0, 0)
			
			@map.tiles.each {|tile| image.pixel tile.x, tile.y, :color => tile.color}							

			image.save "rendered_maps/rendered_map.png"	
			
      close     	
    end
  end
end

window = MapOutput.new
window.show
