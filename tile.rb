require 'gosu'

class Tile
  @@grass_color = Gosu::Color.new 0xff5bb55b
  @@sand_color = Gosu::Color.new 0xffffb55b
  @@mountain_color = Gosu::Color.new 0xff555555
  @@water_color = Gosu::Color.new 0xff005082
  @@forest_color = Gosu::Color.new 0xff0d6a05
  @@cave_color = Gosu::Color.new 0x00000000
  @@city_color = Gosu::Color.new 0xffcfbb6a
  @@snow_color = Gosu::Color.new 0xffffffff

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
    return @@cave_color if @type == :cave
    return @@city_color if @type == :city
    return @@snow_color if @type == :snow

		:black
	end
end	
