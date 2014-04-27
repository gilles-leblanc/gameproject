require 'gosu'
require 'yaml'
Dir[File.dirname(__FILE__) + '/UI/screens/*.rb'].each { |file| require file }

# The game's base class. This will be the game's entry point.
class Game < Gosu::Window
  def initialize
    config_values = begin
      YAML.load(File.open('config.yml'))
    end

    super 800, 600, false
    self.caption = config_values['game_name']

    @game_state = GameState.new({ [:none, :start_game] => -> { @current_screen = TitleScreen.new(self, config_values['game_name']) },
                                  [:title_screen, :create_party] => -> { @current_screen = CreatePartyScreen.new(self) } })
    @game_state.change_state [:none, :start_game]
  end

  def update
  end

  def draw
    @current_screen.draw
  end

  def button_down(id)
    close if id == Gosu::KbEscape
    @current_screen.button_down(id)
  end

  def change_state(state_transition)
    @game_state.change_state(state_transition)
  end

  # Holds the current state of the game and allow state changes in the spirit of a FSM
  class GameState
    def initialize(state_transitions)
      @current_state = :none
      @game_states = state_transitions
    end

    def change_state(state_transition)
      @game_states[state_transition].call
    end
  end

end

window = Game.new
window.show
