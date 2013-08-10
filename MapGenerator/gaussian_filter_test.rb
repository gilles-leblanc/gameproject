require './height_map'
require './gaussian_filter'

height_map = HeightMap.new
height_map.number_of_drop_points = 600
height_map.min_particles = 900
height_map.max_particles = 1200
height_map.number_of_passes = 6
height_map.particle_stability_radius = 4

height_map.generate(400, 400)

blur_filter = GaussianFilter.new
filtered_height_map = height_map.filter(blur_filter)
filtered_twice = height_map.filter(blur_filter).filter(blur_filter)

height_map.draw('rendered_maps/unfiltered.png')
filtered_height_map.draw('rendered_maps/filtered.png')
filtered_twice.draw('rendered_maps/filtered_twice.png')
