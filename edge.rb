# Something that is delimited and has an edge. Like the edge of a map.
module Edge
  protected

  def edge_of_map?(x, y)
    x == 0 || y == 0 || x == @width - 1 || y == @height - 1
  end
end