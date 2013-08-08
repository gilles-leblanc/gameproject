require 'gosu'
require 'yaml'
require_relative 'UI/screens/title_screen'

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
    if id == Gosu::KbEscape
      close
    end
  end
end

window = Game.new
window.show
