# TODO: better placement of cities

class CityLocationSpecification
  def tiles_that_satisfy(map)
    allowable_tiles = map.tiles.select {|t| t.type == :grass || t.type == :sand}

    allowable_tiles.select {|t| (map.tile_at(t.x - 1, t.y).type == :water ||     # must be close to water
                                map.tile_at(t.x + 1, t.y).type == :water ||
                                map.tile_at(t.x, t.y - 1).type == :water ||
                                map.tile_at(t.x, t.y + 1).type == :water ||
                                map.tile_at(t.x - 2, t.y).type == :water ||
                                map.tile_at(t.x + 2, t.y).type == :water ||
                                map.tile_at(t.x, t.y - 2).type == :water ||
                                map.tile_at(t.x, t.y + 2).type == :water)  }
  end
end