class Map
	attr_accessor :width, :height
	attr_reader :tiles

	def initialize(width, height)
		@width = width
		@height = height
		
		@tiles = Array.new
	end
	
	def tile_at(x, y)
		@tiles[x + y * @width]
	end
	
protected 

	def edge_of_map?(x, y)
		x == 0 || y == 0 || x == @width - 1 || y == @height - 1
	end
end
