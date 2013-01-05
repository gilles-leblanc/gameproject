require_relative 'height_map'
require_relative 'gaussian_filter'
require_relative 'height_map_configurator'

class RiverFilter
  def initialize(x, y)
    @size = x
  end

  # TODO: fix bug since we do from 0 to x and 0 to y we always start looking for rivers in the same direction
  # TODO: fix bug rivers need to start on the edge of mountains
  def filter(array)
    filtered_array = array.clone

    # select a point to start a river
    # create a rain map to simulate water precipitations
    rain_map = HeightMap.new
    rain_map.visit(HeightMapConfigurator::RainMap_config_1)
    rain_map.generate(@size, @size)

    blur_filter = GaussianFilter.new
    filtered_rain_map = rain_map.filter(blur_filter)

    river_starting_points = Array.new

    # superimpose rain map with array (normal height map) to choose river locations
    (0...@size).each do |y|
      # @size is used since we assume the array is square 2d matrix
      (0...@size).each do |x|
        if filtered_rain_map.data[x + y * @size] >= 100 && filtered_array[x + y * @size] >= 70 &&
            river_starting_points.none? {|p| (p[0] > x - 8 && p[0] < x + 8) &&
                                             (p[1] > y - 8 && p[1] < y + 8)}
          river_starting_points.push([x, y])
        end
      end
    end

    puts "Found #{river_starting_points.length} rivers."

    # create rivers
    river_starting_points.each do |starting_point|
      puts "Starting new river"

      # start river there
      river = Array.new
      river.push(starting_point)
      point = starting_point

      # create river to body of water, we dig until we find water, following terrain inclination
      until river.last[2] == 0
        lowest_neighbor = get_lowest_neighbor(filtered_array, point)
        river.push(lowest_neighbor)
        puts "Added #{lowest_neighbor}"
        point = lowest_neighbor
      end

      # dig actual river
      puts "Digging river"
      river.each {|p| filtered_array[p[0] + p[1] * @size] = 0}
    end

    filtered_array
  end

private

  # TODO: fix bug, always starts looking in the north-west direction for rivers because of order of return_if_lower statements
  def get_lowest_neighbor(filtered_array, point)
    x, y = point[0], point[1]
    lowest_neighbor = [x, y, 256]

    lowest_neighbor = return_if_lower(filtered_array, x, y - 1, lowest_neighbor)
    lowest_neighbor = return_if_lower(filtered_array, x - 1, y, lowest_neighbor)
    lowest_neighbor = return_if_lower(filtered_array, x, y, lowest_neighbor)
    lowest_neighbor = return_if_lower(filtered_array, x + 1, y, lowest_neighbor)
    lowest_neighbor = return_if_lower(filtered_array, x, y + 1, lowest_neighbor)

    lowest_neighbor
  end

  # TODO: fix bug if no neighbor lower but all equal, cause infinite loop
  def return_if_lower(filtered_array, x, y, lowest_neighbor)
    value_at_neighbor = filtered_array[x + y * @size]

    return [x, y, value_at_neighbor] if value_at_neighbor < lowest_neighbor[2]
    lowest_neighbor
  end
end