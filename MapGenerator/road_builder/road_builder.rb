require_relative 'a_star_tile'

class RoadBuilder
  def initialize(map, max_road_distance = 50)
    @map = map
    @max_road_distance = max_road_distance

    # convert tiles to a* star tiles
    @a_star_tiles = @map.tiles.map { |tile| AStarTile.new(tile.x, tile.y, tile, @map) }
  end

  def build_roads
    cities = @a_star_tiles.select { |a_tile| a_tile.tile.type == :city }
    return if cities.length <= 1

    cities.each do |city|
      starting_city = city #cities.pop

      suitable_ending_cities = cities.select { |city| city.guess_distance(starting_city) <= @max_road_distance }
      suitable_ending_cities.sort! { |x,y| x.guess_distance(starting_city) <=> y.guess_distance(starting_city) }

      suitable_ending_cities.each do |ending_city|
        # calculate path and return array
        cost, path = starting_city.path_to(ending_city)

        # change tiles in path (except cities and caves and road) to road tiles
        if not path.nil?
          path.each { |a_tile| if not [:road, :city, :cave].include? a_tile.tile.type then a_tile.tile.type = :road end }
        end
      end
    end
  end
end