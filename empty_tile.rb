# null-object pattern
class EmptyTile
  attr_accessor :type, :x, :y

  def initialize
    @type = :empty_tile
    @x = 0
    @y = 0
    @passable = false
  end

  def color
    :black
  end
end