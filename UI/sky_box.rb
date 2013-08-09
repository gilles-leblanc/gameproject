require_relative './ui_constants'
require_relative './color_palette'

# The UI component for rendering the sky.
class SkyBox
  def initialize(parent_window)
    @parent_window = parent_window
  end

  def draw
    @parent_window.draw_quad(0, 0, ColorPalette::Top_sky_color,
                             0, UiConstants::Sky_Line,
                             ColorPalette::Bottom_sky_color,
                             UiConstants::Width, UiConstants::Sky_Line,
                             ColorPalette::Bottom_sky_color,
                             UiConstants::Width, 0, ColorPalette::Top_sky_color)
  end
end