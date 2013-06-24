require_relative '../map'
require_relative '../tile'
require_relative 'Dungeon/Dungeon'
require_relative 'Dungeon/Cell'

# This class creates a random dungeon using the Dungeon program code.
# It then converts this data to a map usable by this program.
class DungeonFactory
  attr_reader :width, :height

  def initialize
    @width = 30
    @height = 30
  end

  def build
    # create random Dungeon
    dungeon = Dungeon.new(@width, @height)
    tiles = Array.new

    # create map tiles with Dungeon cells
    dungeon.cells.each do |cell_row|
      cell_row.each do |cell|
        case cell.type
          when Cell::BLOCKED, Cell::PERIMETER, Cell::UNALLOCATED
            tiles.push Tile.new(:wall, cell.x, cell.y)
          when Cell::ROOM, Cell::CORRIDOR
            tiles.push Tile.new(:open, cell.x, cell.y)
          when Cell::ENTRANCE
            tiles.push Tile.new(:door, cell.x, cell.y)
          else
            raise "Unknown cell/tile type."
        end
      end
    end

    # place entrance
    entrance_tile = tiles.find { |tile| tile.x == 1 and tile.y == 1 }
    entrance_tile.type = :entrance

    # create Map object with random Dungeon tiles
    dungeon_map = Map.new(@width, @height, tiles)
    dungeon_map.name = "random dungeon"
    dungeon_map
  end
end