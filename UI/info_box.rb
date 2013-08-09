require_relative './ui_constants'

# A UI component display text information.
class InfoBox
  def initialize(parent_window)
    @font = Gosu::Font.new(parent_window, Gosu::default_font_name, UiConstants::Info_Box_Font_Size)
  end

  def draw(map, current_position, compass)
    @font.draw("#{map.name}", UiConstants::Info_Box_x_Placement, UiConstants::Info_Box_y_Placement, 0)
    @font.draw("Position X : #{current_position[:x]}", UiConstants::Info_Box_x_Placement, UiConstants::Info_Box_y_Placement + 20, 0)
    @font.draw("Position Y : #{current_position[:y]}", UiConstants::Info_Box_x_Placement, UiConstants::Info_Box_y_Placement + 40, 0)
    @font.draw("Facing : #{compass[0]}", UiConstants::Info_Box_x_Placement, UiConstants::Info_Box_y_Placement + 60, 0)
    @font.draw("Tile X, Y : #{map.tile_at(current_position[:x], current_position[:y]).type}", UiConstants::Info_Box_x_Placement, UiConstants::Info_Box_y_Placement + 80, 0)
    @font.draw("Tile X, Y - 1 : #{map.tile_at(current_position[:x], current_position[:y] - 1).type}", UiConstants::Info_Box_x_Placement, UiConstants::Info_Box_y_Placement + 100, 0)
  end
end