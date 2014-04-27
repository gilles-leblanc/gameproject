{ [:none, :start_game] => -> { @current_screen = TitleScreen.new(self, config_values['game_name']) },
  [:title_screen, :create_party] => -> { @current_screen = CreatePartyScreen.new(self) } }
