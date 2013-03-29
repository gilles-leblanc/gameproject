require 'gosu'
require 'texplay'
require_relative 'starting_position'
require_relative './MapGenerator/map_factory'
require_relative './color_palette'
require_relative './map_overview'
require_relative 'tile_palette'

# TODO : major refactor SRP + good design

class MapExplorer < Gosu::Window
	Width = 640
 	Height = 480
 	
 	# Determine the speed at which new button presses are processed
 	Ticks_Per_Step = 15
	
	def initialize
    super 800, 600, false
    self.caption = "Map Explorer"
    
    @world_map = MapFactory.make_small_world
    @map = @world_map

    @TilePalette = TilePalette.new(self)

    @starting_position = StartingPosition.new
    @current_position = @starting_position.get(@map)

    @compass = [:north, :west, :south, :east]
    @key_countdown = 0
    
    @font = Gosu::Font.new(self, Gosu::default_font_name, 20)
    
    @map_overview = MapOverview.new(650, 130, self)
  end
  
  def update
  	if @key_countdown > 0
  		@key_countdown -= 1
  		
  		if @key_countdown == 0
  				@key_countdown = Ticks_Per_Step
  				button_presses
  		end
  	end  	
  end
  
  def draw 	 
  	draw_sky
  	draw_ground

    @font.draw("#{@map.name}", 650, 5, 0)
  	@font.draw("Position X : #{@current_position[:x]}", 650, 25, 0)
  	@font.draw("Position Y : #{@current_position[:y]}", 650, 45, 0)
  	@font.draw("Facing : #{@compass[0]}", 650, 65, 0)
    @font.draw("Tile X, Y : #{@map.tile_at(@current_position[:x], @current_position[:y]).type}", 650, 85, 0)
    @font.draw("Tile X, Y - 1 : #{@map.tile_at(@current_position[:x], @current_position[:y] - 1).type}", 650, 105, 0)

  	@map_overview.draw(@map, @current_position, @compass)
  end
  
  def button_down(id)
    close if id == Gosu::KbEscape
    
    if @key_countdown == 0 then
		  # First step
		  @key_countdown = Ticks_Per_Step
      button_presses
  	end
  end
  
private
  def button_presses
    if button_down? Gosu::KbUp
      step_forward
    elsif button_down? Gosu::KbDown
      step_backward
    elsif button_down? Gosu::KbLeft
      @compass.rotate!
    elsif button_down? Gosu::KbRight
      @compass.rotate!(-1)
    end

    # TODO : move out like in update method
    # TODO: change, should be another method or class, will have to handle many tile types, events, chests, caves, cities, other world maps, inns, castles, etc.
    if @map.tile_at(@current_position[:x], @current_position[:y]).type == :city
      @map = @world_map.get_city_at_position(@current_position[:x], @current_position[:y])
      @current_position = @starting_position.get_city_starting_position(@map)
    end
  end

  def step_forward
    case @compass[0]
      when :north
        @current_position[:y] -= 1 if @map.tile_at(@current_position[:x], @current_position[:y] - 1).passable?
      when :south
        @current_position[:y] += 1 if @map.tile_at(@current_position[:x], @current_position[:y] + 1).passable?
      when :west
        @current_position[:x] -= 1 if @map.tile_at(@current_position[:x] - 1, @current_position[:y]).passable?
      when :east
        @current_position[:x] += 1 if @map.tile_at(@current_position[:x] + 1, @current_position[:y]).passable?
    end
  end

  def step_backward
    case @compass[0]
      when :north
        @current_position[:y] += 1 if @map.tile_at(@current_position[:x], @current_position[:y] + 1).passable?
      when :south
        @current_position[:y] -= 1 if @map.tile_at(@current_position[:x], @current_position[:y] - 1).passable?
      when :west
        @current_position[:x] += 1 if @map.tile_at(@current_position[:x] + 1, @current_position[:y]).passable?
      when :east
        @current_position[:x] -= 1 if @map.tile_at(@current_position[:x] - 1, @current_position[:y]).passable?
    end
  end

  Ratio = Width / Height
	Sky_Line = Height / 2
	First_Row_Height = Height - Sky_Line * 0.4
	Second_Row_Height = First_Row_Height - Sky_Line * 0.3 
	Third_Row_Height = Second_Row_Height - Sky_Line * 0.15
	Fourth_Row_Height = Third_Row_Height - Sky_Line * 0.1
	Fifth_Row_Height = Fourth_Row_Height - Sky_Line * 0.05

  First_Row_Width = 0.198 * Width
  Second_Row_Width = 0.3484 * Width
  Third_Row_Width = 0.4234 * Width
  Fourth_Row_Width = 0.4734 * Width

	def draw_sky
		draw_quad(0, 0, ColorPalette::Top_sky_color, 
  					  0, Sky_Line, ColorPalette::Bottom_sky_color, 
  	          Width, Sky_Line, ColorPalette::Bottom_sky_color, 
  	          Width, 0, ColorPalette::Top_sky_color)
	end
	
	# Draw 5 tiles far, 3 tiles wide.
	# First row is 40%, Second row is 30%, Third row is 15%, Fourth row is 10%, Fifth row is 5%
	def draw_ground
    draw_leftmost_ground_tiles
    draw_center_ground_tiles
    draw_rightmost_ground_tiles
  end

  def draw_center_ground_tiles
		# draw tile we stand on	
		tile = tile_in_front(0)
		draw_tile(0, Height, 									# bottom left
							First_Row_Width, First_Row_Height,  			# top left
							Width - First_Row_Width, First_Row_Height,  	# top right
							Width, Height, 						  # bottom right
              tile)
		
		# draw tile in front
    tile = tile_in_front(1)
		draw_tile(First_Row_Width, First_Row_Height, 				# bottom left
							Second_Row_Width, Second_Row_Height,  			# top left
							Width - Second_Row_Width, Second_Row_Height,  	# top right
							Width - First_Row_Width, First_Row_Height, 	  # bottom right
              tile)
		
		# draw 2 tiles in front
    tile = tile_in_front(2)
		draw_tile(Second_Row_Width, Second_Row_Height, 			# bottom left
							Third_Row_Width, Third_Row_Height,  			# top left
							Width - Third_Row_Width, Third_Row_Height,  	# top right
							Width - Second_Row_Width, Second_Row_Height, 	# bottom right
              tile)

		# draw 3 tiles in front
		tile_color = tile_in_front(3)
		draw_tile(Third_Row_Width, Third_Row_Height, 				# bottom left
							Fourth_Row_Width, Fourth_Row_Height,  			# top left
							Width - Fourth_Row_Width, Fourth_Row_Height,  	# top right
							Width - Third_Row_Width, Third_Row_Height, 	  # bottom right
							tile_color)	
							
		# draw 4 tiles in front
    tile = tile_in_front(4)
		draw_tile(Fourth_Row_Width, Fourth_Row_Height, 			# bottom left
							Width / 2, Fifth_Row_Height,  			# top left
							Width / 2, Fifth_Row_Height,  	# top right
							Width - Fourth_Row_Width, Fourth_Row_Height, 	# bottom right
              tile)
	end

  def draw_leftmost_ground_tiles
    # draw tile we stand on
    tile = tile_in_front(0, -1)
    draw_tile(0, Height, 									# bottom left
              0, First_Row_Height,  			# top left
              First_Row_Width, First_Row_Height,  	# top right
              0, Height, 						  # bottom right
              tile)

    # draw tile in front
    tile = tile_in_front(1, -1)
    draw_tile(0, First_Row_Height, 				# bottom left
              0, Second_Row_Height,  			# top left
              Second_Row_Width, Second_Row_Height,  	# top right
              First_Row_Width, First_Row_Height, 	  # bottom right
              tile)

    # draw 2 tiles in front
    tile = tile_in_front(2, -1)
    draw_tile(0, Second_Row_Height, 			# bottom left
              0, Third_Row_Height,  			# top left
              Third_Row_Width, Third_Row_Height,  	# top right
              Second_Row_Width, Second_Row_Height, 	# bottom right
              tile)

    # draw 3 tiles in front
    tile = tile_in_front(3, -1)
    draw_tile(0, Third_Row_Height, 				# bottom left
              0, Fourth_Row_Height,  			# top left
              Fourth_Row_Width, Fourth_Row_Height,  	# top right
              Third_Row_Width, Third_Row_Height, 	  # bottom right
              tile)

    # draw 4 tiles in front
    tile = tile_in_front(4, -1)
    draw_tile(0, Fourth_Row_Height, 			# bottom left
              0, Fifth_Row_Height,  			# top left
              Width / 2, Fifth_Row_Height,  	# top right
              Fourth_Row_Width, Fourth_Row_Height, 	# bottom right
              tile)
  end

  def draw_rightmost_ground_tiles
    # draw tile we stand on
    tile = tile_in_front(0, 1)
    draw_tile(Width, Height, 									# bottom left
              Width - First_Row_Width, First_Row_Height,  			# top left
              Width, First_Row_Height,  	# top right
              Width, Height, 						  # bottom right
              tile)

    # draw tile in front
    tile = tile_in_front(1, 1)
    draw_tile(Width - First_Row_Width, First_Row_Height, 				# bottom left
              Width - Second_Row_Width, Second_Row_Height,  			# top left
              Width, Second_Row_Height,  	# top right
              Width, First_Row_Height, 	  # bottom right.color
              tile)

    # draw 2 tiles in front
    tile = tile_in_front(2, 1)
    draw_tile(Width - Second_Row_Width, Second_Row_Height, 			# bottom left
              Width - Third_Row_Width, Third_Row_Height,  			# top left
              Width, Third_Row_Height,  	# top right
              Width, Second_Row_Height, 	# bottom right
              tile)

    # draw 3 tiles in front
    tile = tile_in_front(3, 1)
    draw_tile(Width - Third_Row_Width, Third_Row_Height, 				# bottom left
              Width - Fourth_Row_Width, Fourth_Row_Height,  			# top left
              Width, Fourth_Row_Height,  	# top right
              Width, Third_Row_Height, 	  # bottom right
              tile)

    # draw 4 tiles in front
    tile = tile_in_front(4, 1)
    draw_tile(Width - Fourth_Row_Width, Fourth_Row_Height, 			# bottom left
              Width / 2, Fifth_Row_Height,  			# top left
              Width, Fifth_Row_Height,  	# top right
              Width, Fourth_Row_Height, 	# bottom right
              tile)
  end

	def tile_in_front(number_of_steps, side_step=0)
		case @compass[0]
		when :north
			@map.tile_at(@current_position[:x] + side_step, @current_position[:y] - 1 * number_of_steps)
		when :south
			@map.tile_at(@current_position[:x] - side_step, @current_position[:y] + 1 * number_of_steps)
		when :west
			@map.tile_at(@current_position[:x] - 1 * number_of_steps, @current_position[:y] - side_step)
		when :east
			@map.tile_at(@current_position[:x] + 1 * number_of_steps, @current_position[:y] + side_step)
		end
	end
	
	def draw_tile (bottom_left_x, bottom_left_y, top_left_x, top_left_y, top_right_x,
								 top_right_y, bottom_right_x, bottom_right_y, tile)

    image = @TilePalette.get_tile_resource(tile)

    if image.nil?
      draw_quad(bottom_left_x, bottom_left_y, tile.color,			# bottom left
                top_left_x, top_left_y, tile.color, 					# top left
                top_right_x, top_right_y, tile.color, 				# top right
                bottom_right_x, bottom_right_y, tile.color) 	# bottom right
    else
      image.draw_as_quad(bottom_left_x, bottom_left_y, 0xFFFFFFFF,			# bottom left
                top_left_x, top_left_y, 0xFFFFFFFF, 					# top left
                top_right_x, top_right_y, 0xFFFFFFFF, 				# top right
                bottom_right_x, bottom_right_y, 0xFFFFFFFF, 1) 	# bottom right
    end
	end
end


window = MapExplorer.new
window.show