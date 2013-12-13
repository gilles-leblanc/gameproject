require_relative 'monster'
require_relative '../../broadcast'
require_relative '../treasure_table'
require_relative '../stats'

# A type of monster the characters can do battle with.
class Ogre < Monster
  include Broadcast

  def initialize(random)
    @name = 'Ogre'
    @nax_hp = @current_hp = 12 + random.rand(0..4)
    @ac = 10
    @xp = 25

    @stats = Stats.new
    @stats.speed = 8
    @stats.accuracy = 16
  end

  def attack(target, random)
    if random.rand(0..3) + @stats.accuracy_modifier >= target.ac
      broadcast "#{@name} crushes #{target.name}."
      target.take_damage(random.rand(2..5))
    else
      broadcast "#{@name} swings widly but misses."
    end
  end

  def treasure
    treasure_table = TreasureTable.new
    treasure_table.medium_amount_of_gold + treasure_table.very_small_chance_for_one_item
  end
end
