# The main game title screen which display's the game's name.
class TitleScreen
  def initialize(parent_window, game_name)
    @parent_window = parent_window
    @font = Gosu::Font.new(parent_window, Gosu.default_font_name, 72)
    @game_name = game_name
  end

  def draw
    @font.draw(@game_name, 50 , @parent_window.height / 3, 0)
  end
end