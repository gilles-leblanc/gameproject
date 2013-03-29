# This class was adapted from a class from the DanaDanger/a_star github repository. Following is the original author, repository website and license.
#
#Author: Dana Contreras
#GitHub Repository: https://github.com/DanaDanger/a_star
#License:
#Adapted by The Indianapolis Star from the pseudocode at http://en.wikipedia.org/w/index.php?title=A*_search_algorithm&oldid=347527833
#
#This adaptation is licensed under the Creative Commons Attribution-Share Alike 3.0 Unported license, available at http://creativecommons.org/licenses/by-sa/3.0/

require_relative 'a_star_node'

class AStarTile < AStarNode
  attr_reader :x, :y, :map, :tile

  def initialize(x, y, tile, map)
    @x = x
    @y = y
    @tile = tile
    @map = map
  end

  def passable?
    @tile.passable?
  end

  def neighbors
    result = [
        @map.tile_at(x, y - 1),
        @map.tile_at(x - 1, y),
        @map.tile_at(x + 1, y),
        @map.tile_at(x, y + 1),
    ]
    result.delete_if {|square| square.nil? || !square.passable?}
    result.map { |tile| AStarTile.new(tile.x, tile.y, tile, @map) }
  end

  def guess_distance(square)
    (x - square.x).abs + (y - square.y).abs
  end

  # used to determine the movement cost of moving from this tile to it's specified @neighbor
  def movement_cost(neighbor)
    case neighbor.tile.type
      when :city
        1
      when :road
        3
      when :grass
        10
      when :snow
        15
      when :forest
        20
      when :snow_forest
        25
      when :sand
        30
      when :cave
        90
      when :water
        100
      when :mountain
        100
      else
        25
    end
  end

  def hash
    (x << 16) | y
  end

  def eql?(obj)
    obj.is_a?(AStarTile) && obj.x == x && obj.y == y && obj.map == map
  end
  alias_method :==, :eql?

  def inspect
    "(#{x},#{y})"
  end
end