# This class was copied verbatim from the DanaDanger/a_star github repository. Following is the original author, repository website and license.
#
#Author: Dana Contreras
#GitHub Repository: https://github.com/DanaDanger/a_star
#License:
#Adapted by The Indianapolis Star from the pseudocode at http://en.wikipedia.org/w/index.php?title=A*_search_algorithm&oldid=347527833
#
#This adaptation is licensed under the Creative Commons Attribution-Share Alike 3.0 Unported license, available at http://creativecommons.org/licenses/by-sa/3.0/

require "set"

class AStarNode
  # Overridden by your AStarNode subclass. Return an array of the nodes that
  # you can move to from this node without crossing any other nodes. For
  # example, if your nodes are squares on a grid, the neighbors would be the
  # squares immediately up, down, left, and right. (If you permit diagonal
  # movement, the neighbors would also include the squares immediately up-left,
  # up-right, down-left, and down-right.)
  def neighbors
    raise NotImplementedError, "you must override AStarNode#neighbors"
  end

  # Overriden by your AStarNode subclass. Return your best guess for the total
  # cost/length of a path between this node and +node+. This method must not
  # overestimate, but it is acceptable (and usually necessary) to
  # underestimate.
  def guess_distance(node)
    raise NotImplementedError, "you must override AStarNode#guess_distance"
  end

  # Optionally overriden by your AStarNode subclass. Return the cost of moving
  # from this node to +neighbor+. You only need to override this method if you
  # want to assign weights or preferences to particular path segments. This
  # method will never be passed a node that is not this node's neighbor.
  def movement_cost(neighbor)
    1
  end

  # Finds the shortest path from this node to +goal+. Returns a two-element
  # array. The first element is the total cost of the path (which will be equal
  # to the length of the path if you don't override movement_cost). The second
  # element is an array containing all of the nodes in the path. The path array
  # will include this node and +goal+.
  #
  # If there is no path between this node and +goal+, the total cost and the
  # path array will both be nil (i.e., the method returns <tt>[nil, nil]</tt>).
  #
  # Note that it is not entirely accurate to say that this method finds *the*
  # shortest path, because it may be possible to traverse the least-cost 
  # distance between two nodes along more than one route. The particular path
  # returned by this method is related non-trivially to your node class' hash
  # and guess_distance methods. Changing either of these methods will cause a
  # different path to be selected when multiple paths have the least cost, but
  # not in a way that is predictable in the general case.
  def path_to(goal)
    closed_nodes = Set.new
    open_nodes = Set.new
    open_nodes.add(self)

    g_scores = { self => 0 }
    h_scores = { self => guess_distance(goal) }
    f_scores = h_scores.dup
    came_from = {}

    until open_nodes.empty?
      fmin_node = nil
      fmin = nil
      open_nodes.each do |node|
        next unless fmin.nil? || f_scores[node] < fmin
        fmin_node = node
        fmin = f_scores[node]
      end

      if fmin_node == goal
        path = []
        node = fmin_node
        while node
          path.unshift(node)
          node = came_from[node]
        end
        return [g_scores[goal], path]
      end

      open_nodes.delete(fmin_node)
      closed_nodes.add(fmin_node)

      fmin_node.neighbors.each do |neighbor|
        next if closed_nodes.include?(neighbor)
        tmp_g_score = g_scores[fmin_node] + fmin_node.movement_cost(neighbor)
        if !open_nodes.include?(neighbor)
          open_nodes.add(neighbor)
          tmp_is_better = true
        elsif tmp_g_score < g_scores[neighbor]
          tmp_is_better = true
        else
          tmp_is_better = false
        end

        if tmp_is_better
          came_from[neighbor] = fmin_node
          g_scores[neighbor] = tmp_g_score
          h_scores[neighbor] = neighbor.guess_distance(goal)
          f_scores[neighbor] = g_scores[neighbor] + h_scores[neighbor]
        end
      end
    end

    return [nil, nil]
  end
end