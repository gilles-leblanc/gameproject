require 'gosu'
require_relative './ui_constants'
require_relative '../mini_tile_palette'

class MapOverview
  def initialize(left, top, parent_window, size = UiConstants::Mini_Tile_Size)
    @left = left
    @top = top
    @size = size
    @parent_window = parent_window
    @tile_palette = MiniTilePalette.new(@parent_window, "MapGenerator")

    @red_arrow_up = Gosu::Image.new(parent_window, "media/red_arrow_up.png", true)
    @red_arrow_left = Gosu::Image.new(parent_window, "media/red_arrow_left.png", true)
    @red_arrow_right = Gosu::Image.new(parent_window, "media/red_arrow_right.png", true)
    @red_arrow_down = Gosu::Image.new(parent_window, "media/red_arrow_down.png", true)
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

    arrow.draw(@left + (UiConstants::Mini_Tile_Size * @size / 2), @top + (UiConstants::Mini_Tile_Size * @size / 2), 0)
  end

  private

  def draw_tile(tile, x, y)
    tile_to_draw = @tile_palette.get_mini_tile_resource(tile)
    tile_to_draw.draw(@left + x * UiConstants::Mini_Tile_Size, @top + y * UiConstants::Mini_Tile_Size, 0)
  end
end
