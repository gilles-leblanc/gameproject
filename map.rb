require_relative 'edge'

class Map
  include Edge

	attr_accessor :width, :height, :name
	attr_reader :tiles

	def initialize(width, height, tiles = nil)
		@width = width
		@height = height

    if tiles == nil
      @tiles = Array.new
    else
      @tiles = tiles
    end
	end
	
	def tile_at(x, y)
		@tiles[x + y * @width]
	end
end
