require 'gosu'

# null-object pattern for an empty tile
class EmptyTile
  attr_accessor :type, :x, :y

  def initialize
    @type = :empty_tile
    @x = 0
    @y = 0
  end

  def passable?
    false
  end

  def color
    Gosu::Color.new 0x00000000
  end
end