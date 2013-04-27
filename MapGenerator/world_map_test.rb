require 'test/unit'
require_relative './world_map'

# tests do not work since adding snow
class WorldMapTest < Test::Unit::TestCase
	def test_map_will_generate_correct_water_tile
		# Arrange
		height_map = [0, 0, 0, 0]
		
		# Act
		map = WorldMap.new(2, 2, height_map)
		
		# Assert
		assert_equal(map.tiles.map {|tile| tile.type}, 
								 [:water, :water, :water, :water])
	end
		
	def test_map_will_generate_correct_tile_types
		# Arrange
		height_map = [0, 0, 0, 0, 0,
		              0, 2, 2, 2, 0,
		              0, 2, 2, 2, 0,
		              0, 2, 2, 2, 0,
		              0, 0, 0, 0, 0]
		
		# Act
		map = WorldMap.new(5, 5, height_map)
		
		# Assert
		assert_equal(map.tiles.map {|tile| tile.type}, 
								 [:water, :water, :water, :water, :water,
		              :water, :sand,  :sand,  :sand,  :water,
		              :water, :sand,  :sand,  :sand,  :water,
		              :water, :sand,  :sand,  :sand,  :water,
		              :water, :water, :water, :water, :water])
	end
	
	def test_map_will_generate_correct_tile_types_2
		# Arrange
		height_map = [0, 0, 0, 0, 0,
		              0, 2, 2, 2, 0,
		              0, 10, 10, 2, 0,
		              0, 2, 2, 1, 0,
		              0, 0, 0, 0, 0]
		
		# Act
		map = WorldMap.new(5, 5, height_map)
		
		# Assert
		assert_equal(map.tiles.map {|tile| tile.type}, 
								 [:water, :water, :water, :water, :water,
		              :water, :sand,  :sand,  :sand,  :water,
		              :water, :grass, :grass, :sand,  :water,
		              :water, :sand,  :sand,  :sand,  :water,
		              :water, :water, :water, :water, :water])
	end
	
	def test_map_will_generate_correct_tile_types_3
		# Arrange
		height_map = [0, 0, 0, 0, 0,
		              0, 2, 0, 2, 1,
		              0, 0, 0, 2, 0,
		              0, 0, 2, 1, 0,
		              0, 0, 0, 3, 0]
		
		# Act
		map = WorldMap.new(5, 5, height_map)
		
		# Assert
		assert_equal(map.tiles.map {|tile| tile.type}, 
								 [:water, :water, :water, :water, :water,
		              :water, :sand,  :water, :sand,  :water,
		              :water, :water, :water, :sand,  :water,
		              :water, :water, :sand,  :sand,  :water,
		              :water, :water, :water, :water, :water])
	end
end
