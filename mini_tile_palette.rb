require 'gosu'

# Some common colors defined here to be reused.
class MiniTilePalette
  def initialize(parent_window, path_prefix = '')
    @water_tile = Gosu::Image.new(parent_window, path_prefix +
              '/media/water.png', true)
    @grass_tile = Gosu::Image.new(parent_window, path_prefix +
              '/media/grass.png', true)
    @mountain_tile = Gosu::Image.new(parent_window, path_prefix +
              '/media/mountain.png', true)
    @sand_tile = Gosu::Image.new(parent_window, path_prefix +
              '/media/sand.png', true)
    @forest_tile = Gosu::Image.new(parent_window, path_prefix +
              '/media/forest.png', true)
    @cave_tile = Gosu::Image.new(parent_window, path_prefix +
              '/media/cave.png', true)
    @city_tile = Gosu::Image.new(parent_window, path_prefix +
              '/media/city.png', true)
    @snow_tile = Gosu::Image.new(parent_window, path_prefix +
              '/media/snow.png', true)
    @snow_forest_tile = Gosu::Image.new(parent_window, path_prefix +
              '/media/snow-forest.png', true)
    @road_tile = Gosu::Image.new(parent_window, path_prefix +
              '/media/road.png', true)
    @open_tile = Gosu::Image.new(parent_window, path_prefix +
              '/media/open.png', true)
    @wall_tile = Gosu::Image.new(parent_window, path_prefix +
              '/media/wall.png', true)
    @door_tile = Gosu::Image.new(parent_window, path_prefix +
              '/media/door.png', true)
    @entrance_tile = Gosu::Image.new(parent_window, path_prefix +
              '/media/entrance.png', true)
    @empty_tile = Gosu::Image.new(parent_window, path_prefix +
         '/media/empty_tile.png', true)
  end

  def get_mini_tile_resource(tile)
    if tile.type == :water
      tile_to_draw = @water_tile
    elsif tile.type == :grass
      tile_to_draw = @grass_tile
    elsif tile.type == :sand
      tile_to_draw = @sand_tile
    elsif tile.type == :forest
      tile_to_draw = @forest_tile
    elsif tile.type == :mountain
      tile_to_draw = @mountain_tile
    elsif tile.type == :cave
      tile_to_draw = @cave_tile
    elsif tile.type == :city
      tile_to_draw = @city_tile
    elsif tile.type == :snow
      tile_to_draw = @snow_tile
    elsif tile.type == :snow_forest
      tile_to_draw = @snow_forest_tile
    elsif tile.type == :road
      tile_to_draw = @road_tile
    elsif tile.type == :open
      tile_to_draw = @open_tile
    elsif tile.type == :wall
      tile_to_draw = @wall_tile
    elsif tile.type == :door
      tile_to_draw = @door_tile
    elsif tile.type == :entrance
      tile_to_draw = @entrance_tile
    else
      tile_to_draw = @empty_tile
    end

    tile_to_draw
  end
end