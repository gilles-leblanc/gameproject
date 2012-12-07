require 'gosu'
require_relative './MapGenerator/map_factory'
require_relative './color_palette'

class MapExplorer < Gosu::Window
	Width = 640
 	Height = 480
 	
 	# Determine the speed at which new button presses are processed
 	Ticks_Per_Step = 30
	
	def initialize
    super Width, Height, false
    self.caption = "Map Explorer"
    
    @map = MapFactory.make(80, 80)
    @current_position = {x: 32, y: 32, direction: :north}
    @key_countdown = 0
  end
  
  def update
  	if @key_countdown > 0
  		@key_countdown -= 1
  		
  		if @key_countdown == 0
  				@key_countdown = Ticks_Per_Step
  				
  				if button_down? Gosu::KbUp
						@current_position[:y] -= 1
					elsif button_down? Gosu::KbDown
						@current_position[:y] += 1
					end
  		end
  	end  	
  end
  
  def draw 	 
  	draw_sky
  	draw_ground
  end
  
  def button_down(id)
    close if id == Gosu::KbEscape
    
    if @key_countdown == 0 then
		  # First step
		  @key_countdown = Ticks_Per_Step
		  
		  if button_down? Gosu::KbUp
				@current_position[:y] -= 1
			elsif button_down? Gosu::KbDown
				@current_position[:y] += 1
			end
  	end
  end
  
private

	def draw_sky
		draw_quad(0, 0, ColorPalette::Top_sky_color, 
  					  0, Height / 2, ColorPalette::Bottom_sky_color, 
  	          Width, Height / 2, ColorPalette::Bottom_sky_color, 
  	          Width, 0, ColorPalette::Top_sky_color)
	end
	
	# TODO: refactor
	def draw_ground
		# draw tile we currently stand on
		tile = @map.tile_at(@current_position[:x], @current_position[:y])
		draw_quad(Width / 3 - Width / 8, Height, tile.color,									 # bottom left
							Width / 3 + Width / 32, Height - Height / 4, tile.color,		 # top left
							Width / 3 * 2 - Width / 32, Height - Height / 4, tile.color, # top right
							Width / 3 * 2 + Width / 8, Height, tile.color)							 # bottom right
		
		# draw left tile
		tile = @map.tile_at(@current_position[:x] - 1, @current_position[:y])
		draw_quad(0, Height, tile.color,																			 # bottom left
							0, Height - Height / 4, tile.color,													 # top left
							Width / 3 + Width / 32, Height - Height / 4, tile.color,		 # top right
							Width / 3 - Width / 8, Height, tile.color)									 # bottom right
		
		# draw right tile
		tile = @map.tile_at(@current_position[:x] + 1, @current_position[:y])
		draw_quad(Width / 3 * 2 + Width / 8, Height, tile.color,						   # bottom left
							Width / 3 * 2 - Width / 32, Height - Height / 4, tile.color, # top left
							Width, Height - Height / 4, tile.color,											 # top right
							Width, Height, tile.color)																	 # bottom right
		
		# draw tile in front
		tile = @map.tile_at(@current_position[:x], @current_position[:y] - 1)
		draw_quad(Width / 3 + Width / 32, Height - Height / 4, tile.color,		 # bottom left
							Width / 3 + Width / 8, Height - Height / 2.5, tile.color,	 # top left
							Width / 3 * 2 - Width / 8, Height - Height / 2.5, tile.color, # top right
							Width / 3 * 2 - Width / 32, Height - Height / 4, tile.color)	 # bottom right
		
		# draw tile in front left
		tile = @map.tile_at(@current_position[:x] -1, @current_position[:y] - 1)
		draw_quad(0, Height - Height / 4, tile.color,		 # bottom left
							0, Height - Height / 2.5, tile.color,	 # top left
							Width / 3 + Width / 8, Height - Height / 2.5, tile.color, # top right
							Width / 3 + Width / 32, Height - Height / 4, tile.color)	 # bottom right
		
		# draw tile in front right
		tile = @map.tile_at(@current_position[:x] + 1, @current_position[:y] - 1)
		draw_quad(Width / 3 * 2 - Width / 32, Height - Height / 4, tile.color,		 # bottom left
							Width / 3 * 2 - Width / 8, Height - Height / 2.5, tile.color,	 # top left
							Width, Height - Height / 2.5, tile.color, # top right
							Width, Height - Height / 4, tile.color)	 # bottom right
		
		# draw two tiles in front
		tile = @map.tile_at(@current_position[:x], @current_position[:y] - 2)
		draw_quad(Width / 3 + Width / 8, Height - Height / 2.5, tile.color,		 # bottom left
							Width / 2, Height - Height / 2, tile.color,	     # top left
							Width / 2, Height - Height / 2, tile.color,  # top right
							Width / 3 * 2 - Width / 8, Height - Height / 2.5, tile.color)# bottom right
		
		# draw two tiles in front left
		tile = @map.tile_at(@current_position[:x] - 1, @current_position[:y] - 2)
		
		# draw two tiles in front right
		tile = @map.tile_at(@current_position[:x] + 1, @current_position[:y] - 2)
		
	end

end


window = MapExplorer.new
window.show
