require_relative 'a_star_tile'

class RoadBuilder
  def initialize(map)
    @map = map

    # convert tiles to a* star tiles
    @a_star_tiles = @map.tiles.map { |tile| AStarTile.new(tile.x, tile.y, tile, @map) }
  end

  def build_roads
    # will need to find out how many roads, between which city, etc.
    # for now, just create one road as a test

    # pick one city
    cities = @a_star_tiles.select { |a_tile| a_tile.tile.type == :city }
    return if cities.length <= 1

    starting_city = cities[0]
    ending_city = cities[1]

    # calculate path and return array
    cost, path = starting_city.path_to(ending_city)

    # change tiles in path (except cities and caves and road) to road tiles
    if not path.nil?
      path.each { |a_tile| if not [:road, :city, :cave].include? a_tile.tile.type then a_tile.tile.type = :road end }
    end
  end
end