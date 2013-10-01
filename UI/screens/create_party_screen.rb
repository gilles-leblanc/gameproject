# The screen where character creation takes places
class CreatePartyScreen
  def initialize(parent_window)
    @parent_window = parent_window
    @font = Gosu::Font.new(parent_window, Gosu.default_font_name, 30)
  end

 def draw
   @font.draw('Create party screen', 150, 300, 0)
 end
end
