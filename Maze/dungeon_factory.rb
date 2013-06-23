require_relative '../map'
require_relative '../tile'
require_relative 'Dungeon/Dungeon'
require_relative 'Dungeon/Cell'

class DungeonFactory
  def build
    dungeon = Dungeon.new(30, 30)
    tiles = Array.new

    dungeon.cells.each do |cell_row|
      cell_row.each do |cell|
        case cell.type
          when Cell::BLOCKED, Cell::PERIMETER, Cell::UNALLOCATED
            tiles.push Tile.new(:wall, cell.x, cell.y)
          when Cell::ROOM, Cell::CORRIDOR
            tiles.push Tile.new(:open, cell.x, cell.y)
          when Cell::ENTRANCE
            tiles.push Tile.new(:entrance, cell.x, cell.y)
          else
            raise "Unknown cell/tile type."
        end
      end
    end

    dungeon_map = Map.new(30, 30, tiles)
    dungeon_map.name = "random dungeon"
    dungeon_map
  end
end