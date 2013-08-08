require_relative 'height_map'
require_relative 'gaussian_filter'
require_relative 'height_map_configurator'

class RiverFilter
  def initialize(x, y, river_configuration = HeightMapConfigurator::RainMap_medium_world)
    @size = x
    @river_configuration = river_configuration
  end

  def filter(array)
    filtered_array = array.clone

    # select a point to start a river
    # create a rain map to simulate water precipitations
    rain_map = HeightMap.new
    rain_map.visit(@river_configuration)
    rain_map.generate(@size, @size)

    blur_filter = GaussianFilter.new
    filtered_rain_map = rain_map.filter(blur_filter)

    river_starting_points = Array.new

    # superimpose rain map with array (normal height map) to choose river locations
    (0...@size).each do |y|
      # @size is used since we assume the array is square 2d matrix
      (0...@size).each do |x|
        if filtered_rain_map.data[x + y * @size] >= 80 && filtered_array[x + y * @size] >= 68 &&
            river_starting_points.none? { |p| (p[0] > x - 4 && p[0] < x + 3) &&
                                          (p[1] > y - 4 && p[1] < y + 3) }
          river_starting_points.push([x, y])
        end
      end
    end

    # create rivers
    river_starting_points.each do |starting_point|

      # start river there
      river = Array.new
      river.push(starting_point)

      # create river to body of water, we dig until we find water, following terrain inclination
      until river.last[2] == 0
        lowest_neighbor = get_lowest_neighbor(filtered_array, river)
        break if lowest_neighbor[0] == river.last[0] && lowest_neighbor[1] == river.last[1]

        river.push(lowest_neighbor)
      end

      # dig actual river
      river.each { |p| filtered_array[p[0] + p[1] * @size] = 0 }
    end

    filtered_array
  end

  private

  def get_lowest_neighbor(filtered_array, river)
    point = river.last
    x, y = point[0], point[1]
    lowest_neighbor = [x, y, 256]

    lowest_neighbor = return_if_lower(filtered_array, x, y - 1, lowest_neighbor, river)
    lowest_neighbor = return_if_lower(filtered_array, x - 1, y, lowest_neighbor, river)
    lowest_neighbor = return_if_lower(filtered_array, x + 1, y, lowest_neighbor, river)
    lowest_neighbor = return_if_lower(filtered_array, x, y + 1, lowest_neighbor, river)

    lowest_neighbor
  end

  def return_if_lower(filtered_array, x, y, lowest_neighbor, river)
    if not river.any? { |p| p[0] == x && p[1] == y }
      value_at_neighbor = filtered_array[x + y * @size]
      return [x, y, value_at_neighbor] if value_at_neighbor < lowest_neighbor[2]
    end

    lowest_neighbor
  end
end