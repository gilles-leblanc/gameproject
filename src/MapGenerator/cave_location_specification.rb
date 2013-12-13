# Return a suitable location for a cave on the world map.
class CaveLocationSpecification
  attr_accessor :already_selected_tiles

  def initialize
    @already_selected_tiles = []
  end

  def tiles_that_satisfy(map)
    allowable_neighbor_tiles = [:road, :grass, :sand, :forest]

    # must be a mountain
    # must be edge of non-mountain region
    # entrance must not be facing water
    map.tiles.select { |t| t.type == :mountain &&
        (allowable_neighbor_tiles.include?(map.tile_at(t.x - 1, t.y).type) ||
            allowable_neighbor_tiles.include?(map.tile_at(t.x + 1, t.y).type) ||
            allowable_neighbor_tiles.include?(map.tile_at(t.x, t.y - 1).type) ||
            allowable_neighbor_tiles.include?(map.tile_at(t.x, t.y + 1).type)
        ) &&

        @already_selected_tiles.none? do |a|
          (t.x >= a[0] - 2 && t.x <= a[0] + 2) &&
          (t.y >= a[1] - 2 && t.y <= a[1] + 2)
        end &&

        # must have 2 mountain neighbor tiles
        map.tiles.count do |n|
          n.x >= t.x - 2 &&
          n.x <= t.x + 2 &&
          n.y >= t.y - 2 &&
          n.y <= t.y + 2 &&
          n.type == :mountain
        end > 1 &&
        # must have 2 non-mountain, non-water neighbor tiles
        map.tiles.count do |n|
            n.x >= t.x - 2 &&
            n.x <= t.x + 2 &&
            n.y >= t.y - 2 &&
            n.y <= t.y + 2 &&
            (n.type != :mountain && n.type != :water)
        end > 1
    }
  end
end