require 'gosu'
require 'texplay'
require_relative '../color_palette'
require_relative '../tile_palette'

class ViewPort
  Width = 640
  Height = 480
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

  def initialize(parent_window)
    @parent_window = parent_window
    @TilePalette = TilePalette.new(parent_window)
  end

  def draw(map, current_position, compass)
    draw_sky
    draw_ground(map, current_position, compass)
  end

private

  def draw_sky
    @parent_window.draw_quad(0, 0, ColorPalette::Top_sky_color,
                            0, Sky_Line, ColorPalette::Bottom_sky_color,
                            Width, Sky_Line, ColorPalette::Bottom_sky_color,
                            Width, 0, ColorPalette::Top_sky_color)
  end

  # Draw 5 tiles far, 3 tiles wide.
  # First row is 40%, Second row is 30%, Third row is 15%, Fourth row is 10%, Fifth row is 5%
  def draw_ground(map, current_position, compass)
    draw_leftmost_ground_tiles(map, current_position, compass)
    draw_center_ground_tiles(map, current_position, compass)
    draw_rightmost_ground_tiles(map, current_position, compass)
  end

  def draw_center_ground_tiles(map, current_position, compass)
    # draw tile we stand on	
    tile = tile_in_front(0, map, current_position, compass)
    draw_tile(0, Height, 									# bottom left
              First_Row_Width, First_Row_Height,  			# top left
              Width - First_Row_Width, First_Row_Height,  	# top right
              Width, Height, 						  # bottom right
              tile)

    # draw tile in front
    tile = tile_in_front(1, map, current_position, compass)
    draw_tile(First_Row_Width, First_Row_Height, 				# bottom left
              Second_Row_Width, Second_Row_Height,  			# top left
              Width - Second_Row_Width, Second_Row_Height,  	# top right
              Width - First_Row_Width, First_Row_Height, 	  # bottom right
              tile)

    # draw 2 tiles in front
    tile = tile_in_front(2, map, current_position, compass)
    draw_tile(Second_Row_Width, Second_Row_Height, 			# bottom left
              Third_Row_Width, Third_Row_Height,  			# top left
              Width - Third_Row_Width, Third_Row_Height,  	# top right
              Width - Second_Row_Width, Second_Row_Height, 	# bottom right
              tile)

    # draw 3 tiles in front
    tile_color = tile_in_front(3, map, current_position, compass)
    draw_tile(Third_Row_Width, Third_Row_Height, 				# bottom left
              Fourth_Row_Width, Fourth_Row_Height,  			# top left
              Width - Fourth_Row_Width, Fourth_Row_Height,  	# top right
              Width - Third_Row_Width, Third_Row_Height, 	  # bottom right
              tile_color)

    # draw 4 tiles in front
    tile = tile_in_front(4, map, current_position, compass)
    draw_tile(Fourth_Row_Width, Fourth_Row_Height, 			# bottom left
              Width / 2, Fifth_Row_Height,  			# top left
              Width / 2, Fifth_Row_Height,  	# top right
              Width - Fourth_Row_Width, Fourth_Row_Height, 	# bottom right
              tile)
  end

  def draw_leftmost_ground_tiles(map, current_position, compass)
    # draw tile we stand on
    tile = tile_in_front(0, -1, map, current_position, compass)
    draw_tile(0, Height, 									# bottom left
              0, First_Row_Height,  			# top left
              First_Row_Width, First_Row_Height,  	# top right
              0, Height, 						  # bottom right
              tile)

    # draw tile in front
    tile = tile_in_front(1, -1, map, current_position, compass)
    draw_tile(0, First_Row_Height, 				# bottom left
              0, Second_Row_Height,  			# top left
              Second_Row_Width, Second_Row_Height,  	# top right
              First_Row_Width, First_Row_Height, 	  # bottom right
              tile)

    # draw 2 tiles in front
    tile = tile_in_front(2, -1, map, current_position, compass)
    draw_tile(0, Second_Row_Height, 			# bottom left
              0, Third_Row_Height,  			# top left
              Third_Row_Width, Third_Row_Height,  	# top right
              Second_Row_Width, Second_Row_Height, 	# bottom right
              tile)

    # draw 3 tiles in front
    tile = tile_in_front(3, -1, map, current_position, compass)
    draw_tile(0, Third_Row_Height, 				# bottom left
              0, Fourth_Row_Height,  			# top left
              Fourth_Row_Width, Fourth_Row_Height,  	# top right
              Third_Row_Width, Third_Row_Height, 	  # bottom right
              tile)

    # draw 4 tiles in front
    tile = tile_in_front(4, -1, map, current_position, compass)
    draw_tile(0, Fourth_Row_Height, 			# bottom left
              0, Fifth_Row_Height,  			# top left
              Width / 2, Fifth_Row_Height,  	# top right
              Fourth_Row_Width, Fourth_Row_Height, 	# bottom right
              tile)
  end

  def draw_rightmost_ground_tiles(map, current_position, compass)
    # draw tile we stand on
    tile = tile_in_front(0, 1, map, current_position, compass)
    draw_tile(Width, Height, 									# bottom left
              Width - First_Row_Width, First_Row_Height,  			# top left
              Width, First_Row_Height,  	# top right
              Width, Height, 						  # bottom right
              tile)

    # draw tile in front
    tile = tile_in_front(1, 1, map, current_position, compass)
    draw_tile(Width - First_Row_Width, First_Row_Height, 				# bottom left
              Width - Second_Row_Width, Second_Row_Height,  			# top left
              Width, Second_Row_Height,  	# top right
              Width, First_Row_Height, 	  # bottom right.color
              tile)

    # draw 2 tiles in front
    tile = tile_in_front(2, 1, map, current_position, compass)
    draw_tile(Width - Second_Row_Width, Second_Row_Height, 			# bottom left
              Width - Third_Row_Width, Third_Row_Height,  			# top left
              Width, Third_Row_Height,  	# top right
              Width, Second_Row_Height, 	# bottom right
              tile)

    # draw 3 tiles in front
    tile = tile_in_front(3, 1, map, current_position, compass)
    draw_tile(Width - Third_Row_Width, Third_Row_Height, 				# bottom left
              Width - Fourth_Row_Width, Fourth_Row_Height,  			# top left
              Width, Fourth_Row_Height,  	# top right
              Width, Third_Row_Height, 	  # bottom right
              tile)

    # draw 4 tiles in front
    tile = tile_in_front(4, 1, map, current_position, compass)
    draw_tile(Width - Fourth_Row_Width, Fourth_Row_Height, 			# bottom left
              Width / 2, Fifth_Row_Height,  			# top left
              Width, Fifth_Row_Height,  	# top right
              Width, Fourth_Row_Height, 	# bottom right
              tile)
  end

  def tile_in_front(number_of_steps, side_step=0, map, current_position, compass)
    case compass[0]
      when :north
        map.tile_at(current_position[:x] + side_step, current_position[:y] - 1 * number_of_steps)
      when :south
        map.tile_at(current_position[:x] - side_step, current_position[:y] + 1 * number_of_steps)
      when :west
        map.tile_at(current_position[:x] - 1 * number_of_steps, current_position[:y] - side_step)
      when :east
        map.tile_at(current_position[:x] + 1 * number_of_steps, current_position[:y] + side_step)
    end
  end

  def draw_tile (bottom_left_x, bottom_left_y, top_left_x, top_left_y, top_right_x,
                top_right_y, bottom_right_x, bottom_right_y, tile)

    image = @TilePalette.get_tile_resource(tile)

    if image.nil?
      @parent_window.draw_quad(bottom_left_x, bottom_left_y, tile.color,			# bottom left
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