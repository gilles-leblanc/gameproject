require_relative '../map'
require_relative '../tile'
require_relative './height_map'
require_relative './cave_location_specification'
require_relative './city_location_specification'

# TODO: replace series of if elsif with more object oriented approach

class WorldMap < Map	
	def initialize(width, height, height_map)
		super(width, height)		
				
		(0...width).each do |x|
			(0...height).each do |y|
				if edge_of_map?(x, y)
					terrain = :water
				elsif height_map[x + y * width] == 0
					terrain = :water
				elsif height_map[x + y * width] >= 70
					terrain = :mountain
				elsif height_map[x + y * width] >= 1 && height_map[x + y * width] <= 2
					terrain = :sand
				elsif height_map[x + y * width] >= 30 && height_map[x + y * width] <= 64
					terrain = :forest
				else
					terrain = :grass
				end
				
				@tiles[x + y * width] = Tile.new(terrain, x, y)
			end
    end

    # place cities
    place_cities

    # place roads

    # place points of interest (caves, castles, lairs, events, signs, text when visiting a certain tile, etc.)
    place_caves(width, height)
  end

private

  def place_cities
    city_location_specification = CityLocationSpecification.new

    ((width * height) / 1250).times do # 1250 is a magic number, the higher the number, the more cities will be present and vice-versa
      possible_city_tiles = city_location_specification.tiles_that_satisfy(self)
      possible_city_tiles.shuffle!
      possible_city_tiles[0].type = :city
    end

    #possible_city_tiles[1].type = :city
    #possible_city_tiles[2].type = :city
    #possible_city_tiles[3].type = :city
    #possible_city_tiles[4].type = :city
  end

  def place_caves(width, height)
    cave_location_specification = CaveLocationSpecification.new

    ((width * height) / 2500).times do  # 2500 is a magic number, the higher the number, the more caves will be present and vice-versa, 2500 is 50x50 which was considered the default small world size at the time of this writing
      possible_cave_tiles = cave_location_specification.tiles_that_satisfy(self)
      possible_cave_tiles.shuffle!

      possible_cave_tiles[0].type = :cave

      if [true, false].shuffle[0]
        possible_cave_tiles[1].type = :cave
      end
    end
  end
end
