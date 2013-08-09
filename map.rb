require_relative 'edge'
require_relative 'empty_tile'

# A map that can be used directly with the game component.
class Map
  include Edge

  attr_accessor :width, :height, :name
  attr_reader :tiles

  def initialize(width, height, tiles = nil)
    @width = width
    @height = height

    if tiles == nil
      @tiles = []
    else
      @tiles = tiles
    end
  end

  def tile_at(x, y)
    tile = nil

    if (x >= 0 && x < width) && (y >= 0 && y < height)
      tile = @tiles[x + y * @width]
    end

    return EmptyTile.new if tile.nil?
    tile
  end
end
