require_relative '../map'
require_relative '../tile'
require_relative './height_map'
require_relative './cave_location_specification'
require_relative './city_location_specification'
require_relative '../RandomNameGeneration/nameable'
require_relative './road_builder/road_builder'

class WorldMap < Map
  include Nameable

	def initialize(width, height, height_map, city_factory, dungeon_factory)
		super(width, height)		

    @name = give_name

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

    place_snow(height)

    # Array that will contain all sub-maps like Dungeons, Cities, etc.
    @sub_maps = Array.new

    place_cities(city_factory)

    # build and place roads to connect the various cities
    road_builder = RoadBuilder.new(self)
    road_builder.build_roads

    place_caves(width, height, dungeon_factory)
  end

  def get_map_at_position(x, y)
    map = @sub_maps.find { |e| e[0] == x && e[1] == y }
    raise "Can't find map at #{x}, #{y}." if map.nil?

    map[2]
  end

private

  def place_snow(height)
    arctic_latitude = height / 15

    arctic_tiles = @tiles.select {|t| t.type != :mountain &&
                                      t.type != :water &&
                                      t.type != :forest &&
                                      t.y <= arctic_latitude }
    arctic_tiles.map {|t| t.type = :snow}

    arctic_forest_tiles = @tiles.select {|t| t.type == :forest &&
                                             t.y <= arctic_latitude }
    arctic_forest_tiles.map {|t| t.type = :snow_forest}

    sub_arctic_tiles = @tiles.select {|t| t.type != :mountain &&
                                          t.type != :water &&
                                          t.y == arctic_latitude + 1 }
    sub_arctic_tiles.map {|t| if [true, false].shuffle[0] then t.type = :snow end }
  end

  def place_cities(city_factory)
    city_location_specification = CityLocationSpecification.new

    ((width * height) / 1250).times do # 1250 is a magic number, the lower the number, the more cities will be present and vice-versa
      possible_city_tiles = city_location_specification.tiles_that_satisfy(self)

      if possible_city_tiles.length > 0
        possible_city_tiles.shuffle!
        possible_city_tiles[0].type = :city

        city = city_factory.build
        @sub_maps.push([possible_city_tiles[0].x, possible_city_tiles[0].y, city])
        city_location_specification.already_selected_tiles.push([possible_city_tiles[0].x, possible_city_tiles[0].y])
      end
    end
  end

  def place_caves(width, height, dungeon_factory)
    cave_location_specification = CaveLocationSpecification.new

    ((width * height) / 2500).times do  # 2500 is a magic number, the lower the number, the more caves will be present and vice-versa, 2500 is 50x50 which was considered the default small world size at the time of this writing
      possible_cave_tiles = cave_location_specification.tiles_that_satisfy(self)

      if possible_cave_tiles.length > 0
        possible_cave_tiles.shuffle!
        possible_cave_tiles[0].type = :cave

        push_dungeon(dungeon_factory, possible_cave_tiles)
        cave_location_specification.already_selected_tiles.push([possible_cave_tiles[0].x, possible_cave_tiles[0].y])

        if possible_cave_tiles.length > 1 && [true, false].shuffle[0]
          possible_cave_tiles = cave_location_specification.tiles_that_satisfy(self)
          possible_cave_tiles.shuffle!
          possible_cave_tiles[0].type = :cave

          push_dungeon(dungeon_factory, possible_cave_tiles)
          cave_location_specification.already_selected_tiles.push([possible_cave_tiles[0].x, possible_cave_tiles[0].y])
        end
      end
    end
  end

  def push_dungeon(dungeon_factory, possible_cave_tiles)
    dungeon = dungeon_factory.build
    @sub_maps.push([possible_cave_tiles[0].x, possible_cave_tiles[0].y, dungeon])
  end
end
