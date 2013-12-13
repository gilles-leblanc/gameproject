# Predefined configurations for height map generation.
module HeightMapConfigurator
  # tested for 60 x 60, simple and double filtering, also works for 80 x 80
  SAMPLE_CONFIG_1 = proc do |height_map|
    height_map.number_of_drop_points = 60
    height_map.min_particles = 400
    height_map.max_particles = 800
    height_map.number_of_passes = 4
    height_map.particle_stability_radius = 1
  end

  # tested for 80 x 80 double-filtering
  CHAIN_OF_HIGH_ISLANDS = proc do |height_map|
    height_map.number_of_drop_points = 30
    height_map.min_particles = 4000
    height_map.max_particles = 8000
    height_map.number_of_passes = 4
    height_map.particle_stability_radius = 1
  end

  # tested for 80 x 80, double-filtering
  LARGE_LOW_ISLAND = proc do |height_map|
    height_map.number_of_drop_points = 100
    height_map.min_particles = 400
    height_map.max_particles = 800
    height_map.number_of_passes = 4
    height_map.particle_stability_radius = 3
  end

  # tested for 60 x 60, no blur
  # this is useable with no or light blurring
  NON_BLUR_TEST = proc do |height_map|
    height_map.number_of_drop_points = 100
    height_map.min_particles = 200
    height_map.max_particles = 400
    height_map.number_of_passes = 20
    height_map.particle_stability_radius = 1
  end

  # tested for 60 x 60, with no blur and with blur
  # great with no blurring for irrigular island with no beach, blurrring makes
  # for full island (occupies all possible square)
  # with very small beaches at corners
  HUGE_MOUNTAIN = proc do |height_map|
    height_map.number_of_drop_points = 400
    height_map.min_particles = 200
    height_map.max_particles = 300
    height_map.number_of_passes = 5
    height_map.particle_stability_radius = 3
  end

  #	tested with 100 x 100 double filtering, average results
  SAMPLE_CONFIG_2 = proc do |height_map|
    height_map.number_of_drop_points = 40
    height_map.min_particles = 400
    height_map.max_particles = 2000
    height_map.number_of_passes = 5
    height_map.particle_stability_radius = 2
  end

  #	50 x 50
  SMALL_WORLD = proc do |height_map|
    height_map.number_of_drop_points = 20
    height_map.min_particles = 400
    height_map.max_particles = 2000
    height_map.number_of_passes = 5
    height_map.particle_stability_radius = 2
  end

  #	80 x 80
  MEDIUM_WORLD = proc do |height_map|
    height_map.number_of_drop_points = 40
    height_map.min_particles = 400
    height_map.max_particles = 2000
    height_map.number_of_passes = 5
    height_map.particle_stability_radius = 2
  end

  #	100 x 100
  LARGE_WORLD = proc do |height_map|
    height_map.number_of_drop_points = 60
    height_map.min_particles = 400
    height_map.max_particles = 2000
    height_map.number_of_passes = 5
    height_map.particle_stability_radius = 2
  end

  #	140 x 140
  VERY_LARGE_WORLD = proc do |height_map|
    height_map.number_of_drop_points = 120
    height_map.min_particles = 400
    height_map.max_particles = 2000
    height_map.number_of_passes = 5
    height_map.particle_stability_radius = 2
  end

  # 80 x 80
  RAINMAP_MEDIUM_WORLD = proc do |height_map|
    height_map.number_of_drop_points = 30
    height_map.min_particles = 400
    height_map.max_particles = 800
    height_map.number_of_passes = 4
    height_map.particle_stability_radius = 1
  end

  # 50 x 50
  RAINMAP_SMALL_WORLD = proc do |height_map|
    height_map.number_of_drop_points = 13
    height_map.min_particles = 300
    height_map.max_particles = 550
    height_map.number_of_passes = 3
    height_map.particle_stability_radius = 1
  end
end
