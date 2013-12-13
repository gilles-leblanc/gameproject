require_relative 'monster'
require_relative '../../broadcast'
require_relative '../treasure_table'
require_relative '../stats'

# A type of monster the characters can do battle with.
class Orc < Monster
  include Broadcast

  def initialize(random)
    @random = random
    @name = 'Orc'
    @nax_hp = @current_hp = 6 + @random.rand(0..3)
    @ac = 7
    @xp = 10

    @stats = Stats.new
    @stats.speed = 10
    @stats.accuracy = 15
  end

  def attack(target)
    if @random.rand(0..3) + @stats.accuracy_modifier >= target.ac
      broadcast "#{@name} hits #{target.name}."
      target.take_damage(@random.rand(2..5))
    else
      broadcast "#{@name} misses."
    end
  end

  def treasure
    TreasureTable.small_amount_of_gold
  end
end
