require_relative './filter_out_of_bounds_specification'

class GaussianFilter
  def initialize
    # the filter kernel value pairs. The first element in each pair represent the
    # distance from the central pixel and the second element the weighted filter value
    @filter_kernel = [[-3, 0.006], [-2, 0.061], [-1, 0.242],
                      [0, 0.383],
                      [1, 0.242], [2, 0.061], [3, 0.006]]
  end

  # this function assumes the array represent a square 2d matrix
  def filter(array)
    @size = Math.sqrt(array.length)

    intermediate_filtered_array = Array.new(array.length, 0)
    filtered_array = Array.new(array.length, 0)

    # filter horizontally
    (0...@size).each do |y|
      # @size is used since we assume the array is square 2d matrix
      (0...@size).each do |x|
        intermediate_filtered_array[x + y * @size] = compute_x_filtered_value(array, x, y)
      end
    end

    # filter vertically
    (0...@size).each do |x|
      # @size is used since we assume the array is square 2d matrix
      (0...@size).each do |y|
        filtered_array[x + y * @size] = compute_y_filtered_value(intermediate_filtered_array, x, y)
      end
    end

    filtered_array
  end

  private

  def compute_x_filtered_value(array, x, y)
    computed_value = 0.0

    @filter_kernel.each do |filter_pair|
      if FilterOutOfBoundsSpecification.satisfied_by?(x, @size, filter_pair[0])
        offset = 0
      else
        offset = filter_pair[0]
      end

      computed_value += filter_pair[1] * array[x + offset + y * @size]
    end

    computed_value.round
  end

  def compute_y_filtered_value(array, x, y)
    computed_value = 0.0

    @filter_kernel.each do |filter_pair|
      if FilterOutOfBoundsSpecification.satisfied_by?(y, @size, filter_pair[0])
        offset = 0
      else
        offset = filter_pair[0]
      end

      computed_value += filter_pair[1] * array[x + (offset + y) * @size]
    end

    computed_value.round
  end
end
