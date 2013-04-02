class InfoBox
  def initialize(parent_window)
    @font = Gosu::Font.new(parent_window, Gosu::default_font_name, 20)
  end

  def draw(map, current_position, compass)
    @font.draw("#{map.name}", 650, 5, 0)
    @font.draw("Position X : #{current_position[:x]}", 650, 25, 0)
    @font.draw("Position Y : #{current_position[:y]}", 650, 45, 0)
    @font.draw("Facing : #{compass[0]}", 650, 65, 0)
    @font.draw("Tile X, Y : #{map.tile_at(current_position[:x], current_position[:y]).type}", 650, 85, 0)
    @font.draw("Tile X, Y - 1 : #{map.tile_at(current_position[:x], current_position[:y] - 1).type}", 650, 105, 0)
  end
end