require 'gosu'
require_relative '../map_overview'
require_relative '../info_box'
require_relative '../view_port'

# The screen where we show the map and the basic controls. This is the main
# screen for everything that is exploration related. It includes a 2d first
# person view of what the character would see. A description of the current
# characters in the party, a mini-map and a compass.
class MapExplorer
  # Determine the speed at which new button presses are processed
  TICKS_PER_STEP = 15

  def initialize(parent_window)
    @parent_window = parent_window

    @model = parent_window.model
    @current_position = parent_window.model.generate_starting_position
    @previous_map_position = []

    @compass = [:north, :west, :south, :east]
    @key_countdown = 0

    @view_port = ViewPort.new(parent_window)
    @info_box = InfoBox.new(parent_window)
    @map_overview = MapOverview.new(650, 130, parent_window)

    @acted = false
  end

  def update
    if @key_countdown > 0
      @key_countdown -= 1

      if @key_countdown == 0
        @key_countdown = TICKS_PER_STEP
        button_presses
      end
    end
  end

  def draw
    @view_port.draw(model.map, @current_position, @compass)
    @info_box.draw(model.map, @current_position, @compass)
    @map_overview.draw(model.map, @current_position, @compass)
  end

  def button_down(id)
    if @key_countdown == 0
      # First step
      @key_countdown = TICKS_PER_STEP
      button_presses
    end
  end

  private

  def model
    @parent_window.model
  end

  def button_presses
    if @parent_window.button_down? Gosu::KbUp
      step_forward
      @acted = false
    elsif @parent_window.button_down? Gosu::KbDown
      step_backward
      @acted = false
    elsif @parent_window.button_down? Gosu::KbLeft
      @compass.rotate!
    elsif @parent_window.button_down? Gosu::KbRight
      @compass.rotate!(-1)
    end

    act_for_tile
  end

  def act_for_tile
    tile_type = model.map.tile_at(@current_position[:x], @current_position[:y]).type
    if tile_type == :city || tile_type == :cave
      @previous_map_position.push([previous_tile, model.map])
      model.map = model.world_map.get_map_at_position(@current_position[:x],
                                            @current_position[:y])
      @current_position = @model.starting_position.get_sub_map_position(model.map)
    end

    if tile_type == :entrance
      old_position = @previous_map_position.pop
      @current_position = old_position[0]
      model.map = old_position[1]
    end

    unless model.map.tile_at(@current_position[:x],
                        @current_position[:y]).event.nil? || @acted
      model.map.tile_at(@current_position[:x], @current_position[:y]).event.act
      @acted = true
    end
  end

  def step_forward
    case @compass[0]
      when :north
        @current_position[:y] -= 1 if model.map.tile_at(@current_position[:x], @current_position[:y] - 1).passable?
      when :south
        @current_position[:y] += 1 if model.map.tile_at(@current_position[:x], @current_position[:y] + 1).passable?
      when :west
        @current_position[:x] -= 1 if model.map.tile_at(@current_position[:x] - 1, @current_position[:y]).passable?
      when :east
        @current_position[:x] += 1 if model.map.tile_at(@current_position[:x] + 1, @current_position[:y]).passable?
    end
  end

  def step_backward
    case @compass[0]
      when :north
        @current_position[:y] += 1 if model.map.tile_at(@current_position[:x], @current_position[:y] + 1).passable?
      when :south
        @current_position[:y] -= 1 if model.map.tile_at(@current_position[:x], @current_position[:y] - 1).passable?
      when :west
        @current_position[:x] += 1 if model.map.tile_at(@current_position[:x] + 1, @current_position[:y]).passable?
      when :east
        @current_position[:x] -= 1 if model.map.tile_at(@current_position[:x] - 1, @current_position[:y]).passable?
    end
  end

  def previous_tile
    case @compass[0]
      when :north
        { x: @current_position[:x], y: @current_position[:y] + 1 }
      when :south
        { x: @current_position[:x], y: @current_position[:y] - 1 }
      when :west
        { x: @current_position[:x] + 1, y: @current_position[:y] }
      when :east
        { x: @current_position[:x] - 1, y: @current_position[:y] }
    end
  end
end
