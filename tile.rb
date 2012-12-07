require 'gosu'

class Tile
  @@Grass_color = Gosu::Color.new 0xff5bb55b
  @@Sand_color = Gosu::Color.new 0xffffb55b
  @@Mountain_color = Gosu::Color.new 0xff555555
  @@Water_color = Gosu::Color.new 0xff005082
  @@Forest_color = Gosu::Color.new 0xff0d6a05

	attr_accessor :type, :x, :y
	
	def initialize(type, x, y)
		@type = type
		@x = x
		@y = y
	end
	
	def color
		return @@Water_color if @type == :water  
		return @@Grass_color if @type == :grass
		return @@Sand_color if @type == :sand
		return @@Forest_color if @type == :forest
		return @@Mountain_color if @type == :mountain
		
		return :black
	end
end	
