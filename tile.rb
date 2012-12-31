require 'gosu'

class Tile
  @@grass_color = Gosu::Color.new 0xff5bb55b
  @@sand_color = Gosu::Color.new 0xffffb55b
  @@mountain_color = Gosu::Color.new 0xff555555
  @@water_color = Gosu::Color.new 0xff005082
  @@forest_color = Gosu::Color.new 0xff0d6a05

	attr_accessor :type, :x, :y
	
	def initialize(type, x, y)
		@type = type
		@x = x
		@y = y
	end

  def color
		return @@water_color if @type == :water
		return @@grass_color if @type == :grass
		return @@sand_color if @type == :sand
		return @@forest_color if @type == :forest
    return @@mountain_color if @type == :mountain

		:black
	end
end	
