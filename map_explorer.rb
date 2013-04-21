require 'gosu'
require_relative 'starting_position'
require_relative './MapGenerator/map_factory'
require_relative './UI/map_overview'
require_relative './UI/info_box'
require_relative './UI/view_port'

class MapExplorer < Gosu::Window
 	# Determine the speed at which new button presses are processed
 	Ticks_Per_Step = 15
	
	def initialize
    super 800, 600, false
    self.caption = "Map Explorer"
    
    @world_map = MapFactory.make_small_world
    @map = @world_map

    @starting_position = StartingPosition.new
    @current_position = @starting_position.get(@map)

    @compass = [:north, :west, :south, :east]
    @key_countdown = 0

    @view_port = ViewPort.new(self)
    @info_box = InfoBox.new(self)
    @map_overview = MapOverview.new(650, 130, self)

    @acted = false
  end
  
  def update
  	if @key_countdown > 0
  		@key_countdown -= 1
  		
  		if @key_countdown == 0
  				@key_countdown = Ticks_Per_Step
  				button_presses
  		end
  	end  	
  end
  
  def draw 	 
  	@view_port.draw(@map, @current_position, @compass)
    @info_box.draw(@map, @current_position, @compass)
  	@map_overview.draw(@map, @current_position, @compass)
  end
  
  def button_down(id)
    close if id == Gosu::KbEscape
    
    if @key_countdown == 0 then
		  # First step
		  @key_countdown = Ticks_Per_Step
      button_presses
  	end
  end
  
private
  def button_presses
    if button_down? Gosu::KbUp
      step_forward
      @acted = false
    elsif button_down? Gosu::KbDown
      step_backward
      @acted = false
    elsif button_down? Gosu::KbLeft
      @compass.rotate!
    elsif button_down? Gosu::KbRight
      @compass.rotate!(-1)
    end

    # TODO : move out like in update method
    # TODO: change, should be another method or class, will have to handle many tile types, events, chests, caves, cities, other world maps, inns, castles, etc.
    if @map.tile_at(@current_position[:x], @current_position[:y]).type == :city
      @map = @world_map.get_city_at_position(@current_position[:x], @current_position[:y])
      @previous_map_position = @current_position
      @current_position = @starting_position.get_city_starting_position(@map)
    end

    unless @map.tile_at(@current_position[:x], @current_position[:y]).event.nil? or @acted
      @map.tile_at(@current_position[:x], @current_position[:y]).event.act
      @acted = true
    end
  end

  def step_forward
    case @compass[0]
      when :north
        @current_position[:y] -= 1 if @map.tile_at(@current_position[:x], @current_position[:y] - 1).passable?
      when :south
        @current_position[:y] += 1 if @map.tile_at(@current_position[:x], @current_position[:y] + 1).passable?
      when :west
        @current_position[:x] -= 1 if @map.tile_at(@current_position[:x] - 1, @current_position[:y]).passable?
      when :east
        @current_position[:x] += 1 if @map.tile_at(@current_position[:x] + 1, @current_position[:y]).passable?
    end
  end

  def step_backward
    case @compass[0]
      when :north
        @current_position[:y] += 1 if @map.tile_at(@current_position[:x], @current_position[:y] + 1).passable?
      when :south
        @current_position[:y] -= 1 if @map.tile_at(@current_position[:x], @current_position[:y] - 1).passable?
      when :west
        @current_position[:x] += 1 if @map.tile_at(@current_position[:x] + 1, @current_position[:y]).passable?
      when :east
        @current_position[:x] -= 1 if @map.tile_at(@current_position[:x] - 1, @current_position[:y]).passable?
    end
  end
end


window = MapExplorer.new
window.show