module HeightMapConfigurator
  # tested for 60 x 60, simple and double filtering, also works for 80 x 80
  Sample_config_1 = Proc.new do |height_map|
    height_map.number_of_drop_points = 60
    height_map.min_particles = 400
    height_map.max_particles = 800
    height_map.number_of_passes = 4
    height_map.particle_stability_radius = 1
  end

  # tested for 80 x 80 double-filtering
  Chain_of_High_Islands = Proc.new do |height_map|
    height_map.number_of_drop_points = 30
    height_map.min_particles = 4000
    height_map.max_particles = 8000
    height_map.number_of_passes = 4
    height_map.particle_stability_radius = 1
  end

  # tested for 80 x 80, double-filtering
  Large_Low_Island = Proc.new do |height_map|
    height_map.number_of_drop_points = 100
    height_map.min_particles = 400
    height_map.max_particles = 800
    height_map.number_of_passes = 4
    height_map.particle_stability_radius = 3
  end

  # tested for 60 x 60, no blur
  # this is useable with no or light blurring
  Non_blur_test = Proc.new do |height_map|
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
  Huge_Mountain = Proc.new do |height_map|
    height_map.number_of_drop_points = 400
    height_map.min_particles = 200
    height_map.max_particles = 300
    height_map.number_of_passes = 5
    height_map.particle_stability_radius = 3
  end

  #	tested with 100 x 100 double filtering, average results
  Sample_config_2 = Proc.new do |height_map|
    height_map.number_of_drop_points = 40
    height_map.min_particles = 400
    height_map.max_particles = 2000
    height_map.number_of_passes = 5
    height_map.particle_stability_radius = 2
  end

  #	50 x 50
  Small_world = Proc.new do |height_map|
    height_map.number_of_drop_points = 20
    height_map.min_particles = 400
    height_map.max_particles = 2000
    height_map.number_of_passes = 5
    height_map.particle_stability_radius = 2
  end

  #	80 x 80
  Medium_world = Proc.new do |height_map|
    height_map.number_of_drop_points = 40
    height_map.min_particles = 400
    height_map.max_particles = 2000
    height_map.number_of_passes = 5
    height_map.particle_stability_radius = 2
  end

  #	100 x 100
  Large_world = Proc.new do |height_map|
    height_map.number_of_drop_points = 60
    height_map.min_particles = 400
    height_map.max_particles = 2000
    height_map.number_of_passes = 5
    height_map.particle_stability_radius = 2
  end

  #	140 x 140
  VeryLarge_world = Proc.new do |height_map|
    height_map.number_of_drop_points = 120
    height_map.min_particles = 400
    height_map.max_particles = 2000
    height_map.number_of_passes = 5
    height_map.particle_stability_radius = 2
  end

  # 80 x 80
  RainMap_medium_world = Proc.new do |height_map|
    height_map.number_of_drop_points = 30
    height_map.min_particles = 400
    height_map.max_particles = 800
    height_map.number_of_passes = 4
    height_map.particle_stability_radius = 1
  end

  # 50 x 50
  RainMap_small_world = Proc.new do |height_map|
    height_map.number_of_drop_points = 13
    height_map.min_particles = 300
    height_map.max_particles = 550
    height_map.number_of_passes = 3
    height_map.particle_stability_radius = 1
  end
end
