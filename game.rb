require 'gosu'
require 'yaml'
require_relative 'UI/screens/title_screen'

# The game's base class. This will be the game's entry point.
class Game < Gosu::Window
  def initialize
    config_values = begin
      YAML.load(File.open('config.yml'))
    end

    super 800, 600, false
    self.caption = config_values['game_name']

    @title_screen = TitleScreen.new(self, config_values['game_name'])
  end

  def update
  end

  def draw
    @title_screen.draw
  end

  def button_down(id)
    close if id == Gosu::KbEscape
  end
end

window = Game.new
window.show
