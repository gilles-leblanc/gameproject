require_relative 'monster'
require_relative '../../broadcast'
require_relative '../treasure_table'
require_relative '../stats'

# A type of monster the characters can do battle with.
class GiantRat < Monster
  include Broadcast

  def initialize(random)
    @random = random
    @name = 'Giant Rat'
    @nax_hp = @current_hp = 2
    @ac = 5
    @xp = 2

    @stats = Stats.new
    @stats.speed = 14
    @stats.accuracy = 13
  end

  def attack(target)
    if @random.rand(0..3) + @stats.accuracy_modifier >= target.ac
      broadcast "#{@name} bites #{target.name}."
      target.take_damage(@random.rand(1..2))
    else
      broadcast "#{@name} misses."
    end
  end

  def treasure
    TreasureTable.none
  end
end
