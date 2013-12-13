# Intended to become a default base class for monsters.
class Monster
  attr_reader :name, :stats, :xp
  attr_accessor :max_hp, :current_hp, :ac

  def take_damage(damage)
    @current_hp -= damage
    broadcast "#{@name} takes #{damage} points of damage."
    broadcast "#{@name} is defeated." if @current_hp <= 0
    broadcast ''
  end
end
