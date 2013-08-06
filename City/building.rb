# The physical representation of a building for a city.
# This class can create a new building but will not create
# it's events/content.
class Building
  attr_reader :bounding_box_x, :bounding_box_y
  attr_accessor :bitmap

  def initialize(bounding_box_x, bounding_box_y, facing)
    @bounding_box_x = bounding_box_x
    @bounding_box_y = bounding_box_y

    @bitmap = Hash.new(:open)

    place_blocks
    place_door(facing) if @bitmap.any? { |key, value| value == :wall }
  end

  def draw_on(city, coordinates)
    for x in 0..@bounding_box_x
      for y in 0..@bounding_box_y
        city.tile_at(x + coordinates[0], y + coordinates[1])
          .type = @bitmap[[x, y]]
      end
    end
  end

  private

  def place_blocks
    if [true, false].shuffle.first
      paint_block_1
    end

    if [true, false].shuffle.first
      paint_block_2
    end

    if [true, false].shuffle.first
      paint_block_3
    end

    if [true, false].shuffle.first
      paint_block_4
    end

    if [true, false, false, false, false].shuffle.first
      remove_block
    end
  end

  def paint_block_1
    @bitmap[[1, 1]] = :wall
    @bitmap[[1, 2]] = :wall
    @bitmap[[2, 1]] = :wall
    @bitmap[[2, 2]] = :wall
  end

  def paint_block_2
    @bitmap[[2, 1]] = :wall
    @bitmap[[2, 2]] = :wall
    @bitmap[[3, 1]] = :wall
    @bitmap[[3, 2]] = :wall
  end

  def paint_block_3
    @bitmap[[1, 2]] = :wall
    @bitmap[[1, 3]] = :wall
    @bitmap[[2, 2]] = :wall
    @bitmap[[2, 3]] = :wall
  end

  def paint_block_4
    @bitmap[[2, 2]] = :wall
    @bitmap[[2, 3]] = :wall
    @bitmap[[3, 2]] = :wall
    @bitmap[[3, 3]] = :wall
  end

  def remove_block
    remove_at = [[1, 2], [3, 2]].shuffle.first
    @bitmap[remove_at] = :open
  end

  def place_door(facing)
    key = @bitmap.select do |k, v|
      v == :wall && k[k_value(facing)] == max_value(facing)
    end.keys.shuffle.first

    @bitmap[key] = :door
  end

  def max_value(facing)
    case facing
      when :north
        max_value = @bitmap.select { |k, v| v == :wall }.keys.min { |a, b| a[1] <=> b[1] }[1]
      when :south
        max_value = @bitmap.select { |k, v| v == :wall }.keys.max { |a, b| a[1] <=> b[1] }[1]
      when :east
        max_value = @bitmap.select { |k, v| v == :wall }.keys.max { |a, b| a[0] <=> b[0] }[0]
      when :west
        max_value = @bitmap.select { |k, v| v == :wall }.keys.min { |a, b| a[0] <=> b[0] }[0]
      else
        max_value = @bitmap.select { |k, v| v == :wall }.keys.min { |a, b| a[1] <=> b[1] }[1]
    end
    max_value
  end

  def k_value(facing)
    return 1 if facing == :north || facing == :south
    0
  end
end
