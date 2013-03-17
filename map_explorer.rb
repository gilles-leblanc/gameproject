require 'gosu'
require_relative './MapGenerator/map_factory'
require_relative './color_palette'
require_relative './map_overview'

class MapExplorer < Gosu::Window
	Width = 640
 	Height = 480
 	
 	# Determine the speed at which new button presses are processed
 	Ticks_Per_Step = 20
	
	def initialize
    super 800, 600, false
    self.caption = "Map Explorer"
    
    @map = MapFactory.make_small_world
    @current_position = {x: 32, y: 32, direction: :north}
    @key_countdown = 0
    
    @font = Gosu::Font.new(self, Gosu::default_font_name, 20)
    
    @map_overview = MapOverview.new(650, 130, self)
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
  	#draw_ground

  	@font.draw("Position X : #{@current_position[:x]}", 660, 20, 0)
  	@font.draw("Position Y : #{@current_position[:y]}", 660, 40, 0)
  	@font.draw("Facing : #{@current_position[:direction]}", 660, 60, 0)
    @font.draw("Tile X, Y - 1 : #{@map.tile_at(@current_position[:x], @current_position[:y] - 1).type}", 660, 100, 0)
    @font.draw("Tile X, Y : #{@map.tile_at(@current_position[:x], @current_position[:y]).type}", 660, 80, 0)

  	@map_overview.draw(@map, @current_position)
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
	Sky_Line = Height / 2
	First_Row_Height = Height - Sky_Line * 0.4
	Second_Row_Height = First_Row_Height - Sky_Line * 0.3 
	Third_Row_Height = Second_Row_Height - Sky_Line * 0.15
	Fourth_Row_Height = Third_Row_Height - Sky_Line * 0.1
	Fifth_Row_Height = Fourth_Row_Height - Sky_Line * 0.05 

	def draw_sky
		draw_quad(0, 0, ColorPalette::Top_sky_color, 
  					  0, Sky_Line, ColorPalette::Bottom_sky_color, 
  	          Width, Sky_Line, ColorPalette::Bottom_sky_color, 
  	          Width, 0, ColorPalette::Top_sky_color)
	end
	
	# Draw 5 tiles far, 3 tiles wide. 
	# First row is 30/70 tall, Second row is 20/70 tall, Third row is 10/70 tall, Fourth row is ~8/70 tall, Fifth row is 5/70 tall
	# or 
	# First row is 40%, Second row is 30%, Third row is 15%, Fourth row is 10%, Fifth row is 5%
	def draw_ground
		# draw tile we stand on	
		tile_color = tile_in_front(0).color
		draw_tile(0, Height, 									# bottom left
							0, First_Row_Height,  			# top left
							Width, First_Row_Height,  	# top right
							Width, Height, 						  # bottom right
							tile_color)
		
		# draw tile in front
		tile_color = tile_in_front(1).color
		draw_tile(0, First_Row_Height, 				# bottom left
							0, Second_Row_Height,  			# top left
							Width, Second_Row_Height,  	# top right
							Width, First_Row_Height, 	  # bottom right
							tile_color)		
		
		# draw 2 tiles in front
		tile_color = tile_in_front(2).color
		draw_tile(0, Second_Row_Height, 			# bottom left
							0, Third_Row_Height,  			# top left
							Width, Third_Row_Height,  	# top right
							Width, Second_Row_Height, 	# bottom right
							tile_color)		
							
		# draw 3 tiles in front
		tile_color = tile_in_front(3).color
		draw_tile(0, Third_Row_Height, 				# bottom left
							0, Fourth_Row_Height,  			# top left
							Width, Fourth_Row_Height,  	# top right
							Width, Third_Row_Height, 	  # bottom right
							tile_color)	
							
		# draw 4 tiles in front
		tile_color = tile_in_front(3).color
		draw_tile(0, Fourth_Row_Height, 			# bottom left
							0, Fifth_Row_Height,  			# top left
							Width, Fifth_Row_Height,  	# top right
							Width, Fourth_Row_Height, 	# bottom right
							tile_color)			
				
	end
	
	def tile_in_front(number_of_steps)
		case @current_position[:direction] 
		when :north
			@map.tile_at(@current_position[:x], @current_position[:y] - 1 * number_of_steps)			
		when :south
			@map.tile_at(@current_position[:x], @current_position[:y] + 1 * number_of_steps)			
		when :west
			@map.tile_at(@current_position[:x] - 1 * number_of_steps, @current_position[:y])
		when :east
			@map.tile_at(@current_position[:x] + 1 * number_of_steps, @current_position[:y])
		end
	end
	
	def draw_tile (bottom_left_x, bottom_left_y, top_left_x, top_left_y, top_right_x,
								 top_right_y, bottom_right_x, bottom_right_y, tile_color)
		draw_quad(bottom_left_x, bottom_left_y, tile_color,			# bottom left
							top_left_x, top_left_y, tile_color, 					# top left
							top_right_x, top_right_y, tile_color, 				# top right
							bottom_right_x, bottom_right_y, tile_color) 	# bottom right
	end
end


window = MapExplorer.new
window.show
