require 'gosu'

class TilePalette
  def initialize(parent_window)
    @water_tile = nil
    @grass_tile = Gosu::Image.new(parent_window, "media/grass.BMP", true)
    @mountain_tile = Gosu::Image.new(parent_window, "media/mountain.BMP", true)
    @sand_tile = Gosu::Image.new(parent_window, "media/sand.BMP", true)
    @forest_tile = Gosu::Image.new(parent_window, "media/forest.BMP", true)
    @cave_tile = Gosu::Image.new(parent_window, "media/cave.BMP", true)
    @city_tile = Gosu::Image.new(parent_window, "media/city.BMP", true)
    @snow_tile = Gosu::Image.new(parent_window, "media/snow.BMP", true)
    @snow_forest_tile = nil
    @road_tile = Gosu::Image.new(parent_window, "media/road.BMP", true)
    @open_tile = Gosu::Image.new(parent_window, "media/open.BMP", true)
    @wall_tile = Gosu::Image.new(parent_window, "media/wall.BMP", true)
    @door_tile = nil
    @entrance_tile = nil
    @empty_tile = nil
  end

  def get_tile_resource(tile)
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