require_relative 'monster'
require_relative '../../broadcast'
require_relative '../treasure_table'
require_relative '../stats'

# A type of monster the characters can do battle with.
class GiantBat < Monster
  include Broadcast

  def initialize(random)
    @random = random
    @name = 'Giant Bat'
    @nax_hp = @current_hp = 2
    @ac = 6
    @xp = 2

    @stats = Stats.new
    @stats.speed = 15
    @stats.accuracy = 10
  end

  def attack(target)
    if @random.rand(0..3) + @stats.accuracy_modifier >= target.ac
      broadcast "#{@name} bites #{target.name}."
      target.take_damage(1)
    else
      broadcast "#{@name} sweeps by."
    end
  end

  def treasure
    TreasureTable.none
  end
end
