# A single particle used in height map generation by particle deposition.
# This particle is meant to be deposited on the map and then agitated so that
# it falls in it's correct position.
class Particle
  attr_reader :stability_radius

  def initialize(stability_radius = 1)
    @stability_radius = stability_radius
  end

  def drop(height_map, x, y, size_x)
    drop_point = x + y * size_x

    if height_map[drop_point] == 0
      height_map[drop_point] += 1
    else
      agitate(height_map, x, y, size_x, drop_point)
    end
  end

  private

  def agitate(height_map, x, y, size_x, drop_point)
    # compile list of lower level neighbors
    lower_neighbors = []

    for index_x in x - @stability_radius..x + @stability_radius
      for index_y in y - @stability_radius..y + @stability_radius
        check_and_add_neighbor(index_x, index_y, size_x, lower_neighbors,
                               drop_point, height_map)
      end
    end

    if lower_neighbors.length == 0
      # no lower neighbors, leave particle on drop point
      height_map[drop_point] += 1
    else
      # randomly select one of these neighbors and put particle to this neighbor
      selected = lower_neighbors.shuffle.first
      height_map[selected] += 1
    end
  end

  def check_and_add_neighbor(x, y, size_x, lower_neighbors, drop_point,
      height_map)

    unless height_map[x + y * size_x].nil?
      if height_map[x + y * size_x] < height_map[drop_point]
        lower_neighbors.push(x + y * size_x)
      end
    end
  end
end
