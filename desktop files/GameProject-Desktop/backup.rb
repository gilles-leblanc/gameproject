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
