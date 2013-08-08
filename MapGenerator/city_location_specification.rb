# Return a suitable location for a city on the world map.
class CityLocationSpecification
  attr_accessor :already_selected_tiles

  def initialize
    @already_selected_tiles = []
  end

  def tiles_that_satisfy(map)
    allowable_tiles = map.tiles.select { |t| t.type == :grass || t.type == :sand }

    # must be close to water
    allowable_tiles.select { |t| (map.tile_at(t.x - 1, t.y).type == :water ||
        map.tile_at(t.x + 1, t.y).type == :water ||
        map.tile_at(t.x, t.y - 1).type == :water ||
        map.tile_at(t.x, t.y + 1).type == :water ||
        map.tile_at(t.x - 2, t.y).type == :water ||
        map.tile_at(t.x + 2, t.y).type == :water ||
        map.tile_at(t.x, t.y - 2).type == :water ||
        map.tile_at(t.x, t.y + 2).type == :water) &&

        @already_selected_tiles.none? do |a|
          (t.x >= a[0] - 3 && t.x <= a[0] + 3) &&
          (t.y >= a[1] - 3 && t.y <= a[1] + 3)
        end
    }
  end
end
