require 'gosu'
require 'texplay'
require './world_map.rb'
require './height_map_configurator'
require '../mini_tile_palette'
require './map_factory'

# a simple way to output the various maps
# the reason for this file is to be able to view the maps during the
# development of the map generator
class MapOutput < Gosu::Window
  def initialize
    @x, @y = 80, 80

    super @x * 10, @y * 10, false
    self.caption = 'Map Output'

    @map = MapFactory.make(@x, @y, HeightMapConfigurator::Medium_world,
                           HeightMapConfigurator::RainMap_medium_world)
    @tile_palette = MiniTilePalette.new(self, '.')
  end

  def update
  end

  def draw
    font = Gosu::Font.new(self, Gosu::default_font_name, 20)

    @map.tiles.each do |tile|
      tile_to_draw = @tile_palette.get_mini_tile_resource(tile)
      tile_to_draw.draw(tile.x * 10, tile.y * 10, 0)
      font.draw(@map.name, 10, 10, 0)
    end
  end

  def button_down(id)
    close if id == Gosu::KbEscape
  end
end

window = MapOutput.new
window.show
