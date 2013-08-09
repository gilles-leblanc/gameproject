require_relative '../../broadcast'
require_relative '../treasure_table'
require_relative '../stats'

# A type of monster the characters can do battle with.
class Goblin
  include Broadcast

  attr_reader :name, :stats, :xp
  attr_accessor :max_hp, :current_hp, :ac

  def initialize(random)
    @name = 'Goblin'
    @nax_hp = @current_hp = 4 + random.rand(0..2)
    @ac = 6
    @xp = 5

    @stats = Stats.new
    @stats.speed = 10
    @stats.accuracy = 14
  end

  def attack(target, random)
    if random.rand(0..3) + @stats.accuracy_modifier >= target.ac
      broadcast "#{@name} hits #{target.name}."
      target.take_damage(random.rand(2..4))
    else
      broadcast "#{@name} misses."
    end
  end

  def take_damage(damage)
    @current_hp -= damage
    broadcast "#{@name} takes #{damage} points of damage."
    broadcast "#{@name} is defeated." if @current_hp <= 0
    broadcast ''
  end

  def treasure
    TreasureTable.small_amount_of_gold
  end
end
