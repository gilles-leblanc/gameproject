require_relative '../map'
require_relative '../tile'
require_relative './height_map'

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
	end			
end
