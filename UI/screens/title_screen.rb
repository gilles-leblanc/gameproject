# The main game title screen which display's the game's name.
class TitleScreen
  def initialize(parent_window, game_name)
    @parent_window = parent_window
    @title_font = Gosu::Font.new(parent_window, Gosu.default_font_name, 72)
    @other_font = Gosu::Font.new(parent_window, Gosu.default_font_name, 42)
    @game_name = game_name
  end

  def draw
    @title_font.draw(@game_name, 50 , @parent_window.height / 3, 0)
    @other_font.draw('(S)tart new game', @parent_window.width / 2,
                     @parent_window.height / 3 + 60, 0)
    @other_font.draw('(L)oad existing game', @parent_window.width / 2,
                     @parent_window.height / 3 + 90, 0)
  end

  def button_down(id)
    @parent_window.change_state [:title_screen, :create_party] if id == Gosu::KbS
    @parent_window.change_state [:title_screen, :load_game] if id == Gosu::KbL
  end
end
