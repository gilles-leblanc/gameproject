# must be accessible    # not yet implemented

class CaveLocationSpecification
  def tiles_that_satisfy(map)
    allowable_neighbor_tiles = [:road, :grass, :sand, :forest]

    map.tiles.select {|t| t.type == :mountain &&           # must be a mountain
                           (allowable_neighbor_tiles.include?(map.tile_at(t.x - 1, t.y).type) ||   # must be edge of non-mountain region
                            allowable_neighbor_tiles.include?(map.tile_at(t.x + 1, t.y).type) ||   # entrance must not be facing water
                            allowable_neighbor_tiles.include?(map.tile_at(t.x, t.y - 1).type) ||
                            allowable_neighbor_tiles.include?(map.tile_at(t.x, t.y + 1).type)
                           ) &&

                          map.tiles.count {|n| n.x >= t.x - 2 &&             # must not be next to another cave
                              n.x <= t.x + 2 &&
                              n.y >= t.y - 2 &&
                              n.y <= t.y + 2 &&
                              n.type == :cave} == 0  &&

                          map.tiles.count {|n| n.x >= t.x - 2 &&             # must have 2 mountain neighbor tiles
                                               n.x <= t.x + 2 &&
                                               n.y >= t.y - 2 &&
                                               n.y <= t.y + 2 &&
                                               n.type == :mountain} > 1  &&
                          map.tiles.count {|n| n.x >= t.x - 2 &&             # must have 2 non-mountain, non-water neighbor tiles
                                               n.x <= t.x + 2 &&
                                               n.y >= t.y - 2 &&
                                               n.y <= t.y + 2 &&
                                               (n.type != :mountain && n.type != :water)} > 1
                      }
  end
end