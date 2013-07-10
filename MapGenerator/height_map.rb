require 'gosu'
require 'texplay'
require_relative './particle'

class HeightMap
  attr_accessor :number_of_drop_points, :min_particles, :max_particles,
                :number_of_passes, :particle_stability_radius

  attr_reader :data

  def initialize
    @number_of_drop_points = 5
    @min_particles = 100
    @max_particles = 400
    @number_of_passes = 4
    @particle_stability_radius = 1
  end

  # Load the data from an existing height map array
  def load(existing_map_data, size_x)
    @data = existing_map_data
    @size_x = size_x
  end

  # Return a new height map, created by using the filter parameter on the current height map
  def filter(filter)
    filtered_height_map = HeightMap.new
    filtered_height_map.load(filter.filter(@data), @size_x)
    return filtered_height_map
  end

  # Uses particle deposition algorithm to generate HeightMap
  def generate(size_x, size_y)
    @size_x = size_x
    @data = Array.new(size_x * size_y, 0)
    first_iteration = true

    number_of_passes.times do
      drops = create_drops

      # initial drop position is at the center of the map
      drop_point_x, drop_point_y = size_x / 2, size_y / 2

      drops.each do |drop|
        # drop particles
        drop.each { |particle| particle.drop(@data, drop_point_x, drop_point_y, size_x) }

        # move drop point for next drop
        if first_iteration then
          drop_point_x = rand(size_x - 8) + 4 # make sure that particles
          drop_point_y = rand(size_y - 8) + 4 # aren't created near the edges
        else
          drop_point_x = rand(size_x / 2) + size_x / 4
          drop_point_y = rand(size_y / 2) + size_y / 4
        end
      end

      first_iteration = false
      change_variables_for_next_pass
    end

    return @data
  end

  def draw(file_name="rendered_height_map.png")
    window = Gosu::Window.new(@size_x, @size_x, false)
    image = TexPlay.create_image(window, @size_x, @size_x, :color => Gosu::Color::BLACK)
    image.draw(0, 0, 0)

    for y in 0...@size_x
      for x in 0...@size_x
        grayscale = (@data[x + y * @size_x] * 4.0) / 1000.0
        image.pixel x, y, :color => [grayscale, grayscale, grayscale]
      end
    end

    image.save(file_name)
  end

  def visit(block)
    block.call self
  end

  private

  # create the drops and fill them with a random number of particles
  def create_drops
    drops = []
    @number_of_drop_points.times do
      number_in_this_drop = rand(@max_particles - @min_particles) + @min_particles
      drops.push(Array.new(number_in_this_drop, Particle.new(@particle_stability_radius)))
    end

    return drops
  end

  # change the parameters that control the generator to account for the next iteration
  def change_variables_for_next_pass
    @number_of_drop_points /= 2
    @number_of_passes -= 1
    @min_particles = (@min_particles * 1.1).round
    @max_particles = (@max_particles * 1.1).round
  end
end
