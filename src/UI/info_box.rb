require_relative './ui_constants'

# A UI component display text information.
class InfoBox
  def initialize(parent_window)
    @font = Gosu::Font.new(parent_window, Gosu.default_font_name,
                           UiConstants::INFO_BOX_FONT_SIZE)
  end

  def draw(map, current_position, compass)
    @font.draw("#{map.name}", UiConstants::INFO_BOX_X_PLACEMENT,
               UiConstants::INFO_BOX_Y_PLACEMENT, 0)

    @font.draw("Position X : #{current_position[:x]}",
               UiConstants::INFO_BOX_X_PLACEMENT,
               UiConstants::INFO_BOX_Y_PLACEMENT + 20, 0)

    @font.draw("Position Y : #{current_position[:y]}",
               UiConstants::INFO_BOX_X_PLACEMENT,
               UiConstants::INFO_BOX_Y_PLACEMENT + 40, 0)

    @font.draw("Facing : #{compass[0]}", UiConstants::INFO_BOX_X_PLACEMENT,
               UiConstants::INFO_BOX_Y_PLACEMENT + 60, 0)

    @font.draw("Tile X, Y : #{map.tile_at(current_position[:x],
                                          current_position[:y]).type}",
               UiConstants::INFO_BOX_X_PLACEMENT,
               UiConstants::INFO_BOX_Y_PLACEMENT + 80, 0)

    @font.draw("Tile X, Y - 1 : #{map.tile_at(current_position[:x],
                                              current_position[:y] - 1).type}",
               UiConstants::INFO_BOX_X_PLACEMENT,
               UiConstants::INFO_BOX_Y_PLACEMENT + 100, 0)
  end
end