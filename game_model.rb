require_relative 'starting_position'
require_relative './MapGenerator/map_factory'

# A passive model that keeps the general global game information.
class GameModel
  attr_accessor :map, :world_map
  attr_reader :starting_position

  def initialize
    @starting_position = StartingPosition.new
    @world_map = MapFactory.make_small_world
    @map = @world_map
  end

  def generate_starting_position
    @starting_position.get(@map)
  end

  def generate_sub_map_starting_position
    @starting_position.get_sub_map_position(@map)
  end
end
