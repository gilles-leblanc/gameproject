require_relative '../../broadcast'
require_relative '../treasure_table'

class Goblin
  include Broadcast

  attr_reader :name, :speed, :xp
  attr_accessor :hp, :ac

  def initialize(random)
    @name = "Goblin"
    @hp = 4 + random.rand(0..2)
    @ac = 6
    @xp = 5

    @speed = 12

    @accuracy_bonus = 2
  end

  def attack(target, random)
    if random.rand(0..3) + @accuracy_bonus >= target.ac
      broadcast "#{@name} hits #{target.name}."
      target.take_damage(random.rand(2..4))
    else
      broadcast "#{@name} misses."
    end
  end

  def take_damage(hp)
    @hp -= hp
    broadcast "#{@name} takes #{hp} points of damage."
    broadcast "#{@name} is defeated." if @hp <= 0
    broadcast ""
  end

  def treasure
    TreasureTable.small_amount_of_gold
  end
end
