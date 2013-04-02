require 'gosu'
require 'texplay'
require_relative './sky_box'
require_relative './ui_constants'
require_relative '../color_palette'
require_relative '../tile_palette'

class ViewPort
  def initialize(parent_window)
    @parent_window = parent_window
    @tile_palette = TilePalette.new(parent_window)
    @sky_box = SkyBox.new(parent_window)
  end

  def draw(map, current_position, compass)
    @sky_box.draw
    draw_ground(map, current_position, compass)
  end

private

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
    draw_tile(0, UiConstants::Height, 									# bottom left
              UiConstants::First_Row_Width, UiConstants::First_Row_Height,  			# top left
              UiConstants::Width - UiConstants::First_Row_Width, UiConstants::First_Row_Height,  	# top right
              UiConstants::Width, UiConstants::Height, 						  # bottom right
              tile)

    # draw tile in front
    tile = tile_in_front(1, map, current_position, compass)
    draw_tile(UiConstants::First_Row_Width, UiConstants::First_Row_Height, 				# bottom left
              UiConstants::Second_Row_Width, UiConstants::Second_Row_Height,  			# top left
              UiConstants::Width - UiConstants::Second_Row_Width, UiConstants::Second_Row_Height,  	# top right
              UiConstants::Width - UiConstants::First_Row_Width, UiConstants::First_Row_Height, 	  # bottom right
              tile)

    # draw 2 tiles in front
    tile = tile_in_front(2, map, current_position, compass)
    draw_tile(UiConstants::Second_Row_Width, UiConstants::Second_Row_Height, 			# bottom left
              UiConstants::Third_Row_Width, UiConstants::Third_Row_Height,  			# top left
              UiConstants::Width - UiConstants::Third_Row_Width, UiConstants::Third_Row_Height,  	# top right
              UiConstants::Width - UiConstants::Second_Row_Width, UiConstants::Second_Row_Height, 	# bottom right
              tile)

    # draw 3 tiles in front
    tile_color = tile_in_front(3, map, current_position, compass)
    draw_tile(UiConstants::Third_Row_Width, UiConstants::Third_Row_Height, 				# bottom left
              UiConstants::Fourth_Row_Width, UiConstants::Fourth_Row_Height,  			# top left
              UiConstants::Width - UiConstants::Fourth_Row_Width, UiConstants::Fourth_Row_Height,  	# top right
              UiConstants::Width - UiConstants::Third_Row_Width, UiConstants::Third_Row_Height, 	  # bottom right
              tile_color)

    # draw 4 tiles in front
    tile = tile_in_front(4, map, current_position, compass)
    draw_tile(UiConstants::Fourth_Row_Width, UiConstants::Fourth_Row_Height, 			# bottom left
              UiConstants::Width / 2, UiConstants::Fifth_Row_Height,  			# top left
              UiConstants::Width / 2, UiConstants::Fifth_Row_Height,  	# top right
              UiConstants::Width - UiConstants::Fourth_Row_Width, UiConstants::Fourth_Row_Height, 	# bottom right
              tile)
  end

  def draw_leftmost_ground_tiles(map, current_position, compass)
    # draw tile we stand on
    tile = tile_in_front(0, -1, map, current_position, compass)
    draw_tile(0, UiConstants::Height, 									# bottom left
              0, UiConstants::First_Row_Height,  			# top left
              UiConstants::First_Row_Width, UiConstants::First_Row_Height,  	# top right
              0, UiConstants::Height, 						  # bottom right
              tile)

    # draw tile in front
    tile = tile_in_front(1, -1, map, current_position, compass)
    draw_tile(0, UiConstants::First_Row_Height, 				# bottom left
              0, UiConstants::Second_Row_Height,  			# top left
              UiConstants::Second_Row_Width, UiConstants::Second_Row_Height,  	# top right
              UiConstants::First_Row_Width, UiConstants::First_Row_Height, 	  # bottom right
              tile)

    # draw 2 tiles in front
    tile = tile_in_front(2, -1, map, current_position, compass)
    draw_tile(0, UiConstants::Second_Row_Height, 			# bottom left
              0, UiConstants::Third_Row_Height,  			# top left
              UiConstants::Third_Row_Width, UiConstants::Third_Row_Height,  	# top right
              UiConstants::Second_Row_Width, UiConstants::Second_Row_Height, 	# bottom right
              tile)

    # draw 3 tiles in front
    tile = tile_in_front(3, -1, map, current_position, compass)
    draw_tile(0, UiConstants::Third_Row_Height, 				# bottom left
              0, UiConstants::Fourth_Row_Height,  			# top left
              UiConstants::Fourth_Row_Width, UiConstants::Fourth_Row_Height,  	# top right
              UiConstants::Third_Row_Width, UiConstants::Third_Row_Height, 	  # bottom right
              tile)

    # draw 4 tiles in front
    tile = tile_in_front(4, -1, map, current_position, compass)
    draw_tile(0, UiConstants::Fourth_Row_Height, 			# bottom left
              0, UiConstants::Fifth_Row_Height,  			# top left
              UiConstants::Width / 2, UiConstants::Fifth_Row_Height,  	# top right
              UiConstants::Fourth_Row_Width, UiConstants::Fourth_Row_Height, 	# bottom right
              tile)
  end

  def draw_rightmost_ground_tiles(map, current_position, compass)
    # draw tile we stand on
    tile = tile_in_front(0, 1, map, current_position, compass)
    draw_tile(UiConstants::Width, UiConstants::Height, 									# bottom left
              UiConstants::Width - UiConstants::First_Row_Width, UiConstants::First_Row_Height,  			# top left
              UiConstants::Width, UiConstants::First_Row_Height,  	# top right
              UiConstants::Width, UiConstants::Height, 						  # bottom right
              tile)

    # draw tile in front
    tile = tile_in_front(1, 1, map, current_position, compass)
    draw_tile(UiConstants::Width - UiConstants::First_Row_Width, UiConstants::First_Row_Height, 				# bottom left
              UiConstants::Width - UiConstants::Second_Row_Width, UiConstants::Second_Row_Height,  			# top left
              UiConstants::Width, UiConstants::Second_Row_Height,  	# top right
              UiConstants::Width, UiConstants::First_Row_Height, 	  # bottom right.color
              tile)

    # draw 2 tiles in front
    tile = tile_in_front(2, 1, map, current_position, compass)
    draw_tile(UiConstants::Width - UiConstants::Second_Row_Width, UiConstants::Second_Row_Height, 			# bottom left
              UiConstants::Width - UiConstants::Third_Row_Width, UiConstants::Third_Row_Height,  			# top left
              UiConstants::Width, UiConstants::Third_Row_Height,  	# top right
              UiConstants::Width, UiConstants::Second_Row_Height, 	# bottom right
              tile)

    # draw 3 tiles in front
    tile = tile_in_front(3, 1, map, current_position, compass)
    draw_tile(UiConstants::Width - UiConstants::Third_Row_Width, UiConstants::Third_Row_Height, 				# bottom left
              UiConstants::Width - UiConstants::Fourth_Row_Width, UiConstants::Fourth_Row_Height,  			# top left
              UiConstants::Width, UiConstants::Fourth_Row_Height,  	# top right
              UiConstants::Width, UiConstants::Third_Row_Height, 	  # bottom right
              tile)

    # draw 4 tiles in front
    tile = tile_in_front(4, 1, map, current_position, compass)
    draw_tile(UiConstants::Width - UiConstants::Fourth_Row_Width, UiConstants::Fourth_Row_Height, 			# bottom left
              UiConstants::Width / 2, UiConstants::Fifth_Row_Height,  			# top left
              UiConstants::Width, UiConstants::Fifth_Row_Height,  	# top right
              UiConstants::Width, UiConstants::Fourth_Row_Height, 	# bottom right
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

    image = @tile_palette.get_tile_resource(tile)

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