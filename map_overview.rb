require 'gosu'
require 'texplay'
require_relative './color_palette'

class MapOverview
  TILE_SIZE = 10

	def initialize(left, top, parent_window, size=10)
    @left = left
    @top = top
    @size = size

    @red_arrow_up = Gosu::Image.new(parent_window, "media/red_arrow_up.png", true)
    @red_arrow_left = Gosu::Image.new(parent_window, "media/red_arrow_left.png", true)
    @red_arrow_right = Gosu::Image.new(parent_window, "media/red_arrow_right.png", true)
    @red_arrow_down = Gosu::Image.new(parent_window, "media/red_arrow_down.png", true)

    @water_tile = Gosu::Image.new(parent_window, "MapGenerator/media/water.png", true)
    @grass_tile = Gosu::Image.new(parent_window, "MapGenerator/media/grass.png", true)
    @mountain_tile = Gosu::Image.new(parent_window, "MapGenerator/media/mountain.png", true)
    @sand_tile = Gosu::Image.new(parent_window, "MapGenerator/media/sand.png", true)
    @forest_tile = Gosu::Image.new(parent_window, "MapGenerator/media/forest.png", true)
    @cave_tile = Gosu::Image.new(parent_window, "MapGenerator/media/cave.png", true)
    @city_tile = Gosu::Image.new(parent_window, "MapGenerator/media/city.png", true)
    @snow_tile = Gosu::Image.new(parent_window, "MapGenerator/media/snow.png", true)
    @snow_forest_tile = Gosu::Image.new(parent_window, "MapGenerator/media/snow-forest.png", true)
    @road_tile = Gosu::Image.new(parent_window, "MapGenerator/media/road.png", true)
    @empty_tile = Gosu::Image.new(parent_window, "MapGenerator/media/empty_tile.png", true)
	end

	def draw(map, current_position, compass)
    x, y = current_position[:x] - @size / 2, current_position[:y] - @size / 2

    for index_y in 0...(@size)
      for index_x in 0...(@size)
        draw_tile(map.tile_at(x + index_x, y + index_y), index_x, index_y)
      end
    end

    case compass[0]
      when :north
        arrow = @red_arrow_up
      when :south
        arrow = @red_arrow_down
      when :west
        arrow = @red_arrow_left
      when :east
        arrow = @red_arrow_right
    end

    arrow.draw(@left + (TILE_SIZE * @size / 2), @top + (TILE_SIZE * @size / 2), 0)
  end

private

  # TODO: extract this logic it is already used in 2 places (here and map_output and will also be used to show the general world map)
  def draw_tile(tile, x, y)
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
      tile_to_draw == @road_tile
    else
      tile_to_draw = @empty_tile
    end

    tile_to_draw.draw(@left + x * TILE_SIZE, @top + y * TILE_SIZE, 0)
  end
end
