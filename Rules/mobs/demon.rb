require_relative 'monster'
require_relative '../../broadcast'
require_relative '../treasure_table'
require_relative '../stats'

# A type of monster the characters can do battle with.
class Demon < Monster
  include Broadcast

  def initialize(random)
    @random = random
    @name = 'Demon'
    @nax_hp = @current_hp = 50
    @ac = 18
    @xp = 100

    @stats = Stats.new
    @stats.speed = 18
    @stats.accuracy = 18
  end

  def attack(target)
    if @random.rand(0..3) + @stats.accuracy_modifier >= target.ac
      broadcast "#{@name} rends #{target.name}."
      target.take_damage(@random.rand(5..10) + 1)
    else
      broadcast "#{@name} misses."
    end
  end

  def treasure
    treasure_table = TreasureTable.new
    treasure_table.large_amount_of_gold + treasure_table.medium_chance_for_one_item
  end
end

