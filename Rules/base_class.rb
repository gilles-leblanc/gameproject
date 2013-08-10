require_relative '../broadcast'
require_relative 'paper_doll'
require_relative 'actions'
require_relative 'effects'

# This is the base character class on which all other character class are based
# knight, sorcerer, etc.
class BaseClass
  include Broadcast, Actions

  attr_accessor :xp

  attr_reader :name, :level, :max_hp, :current_hp, :sp, :effects, :paper_doll

  # basic stats
  attr_reader :stats

  def initialize(name, stats)
    @level = 1
    @sp = 0
    @ac = 0
    @xp = 0
    @name = name

    @paper_doll = PaperDoll.new
    @paper_doll.armor_categories = [:very_light]
    @paper_doll.weapon_categories = [:simple]

    @stats = stats

    @abilities = {}
    @abilities['a'] = method(:attack)
    @abilities['b'] = method(:block)
    @abilities['p'] = method(:pass)

    @effects = { ac: [], might: [], accuracy: [], endurance: [], intellect: [],
                personality: [], speed: [], luck: [] }
  end

  def take_damage(damage)
    @current_hp -= damage
    broadcast "#{@name} takes #{damage} points of damage."
    broadcast "#{@name} is defeated." if @current_hp <= 0
    broadcast ''
  end

  def heal(hp)
    @current_hp += hp
    @current_hp = @max_hp if @current_hp > @max_hp
  end

  # Level (verb, not the noun) the character by one new level.
  def level
    @level += 1
    new_hp = @hp_per_level + @stats.endurance_modifier
    @max_hp += new_hp
    broadcast "#{@name} gains #{new_hp} hp."
  end

  def ac
    effects_ac_modifier = @effects[:ac].reduce(0) { |a, e| a + e[0] }
    if effects_ac_modifier.nil?
      effects_ac_modifier = 0
    end

    @paper_doll.shield.base_armor_value +
        @paper_doll.armor.armor_value +
        effects_ac_modifier
  end

  def act(enemies)
    Effects.update_effects_timers(@effects)

    broadcast "#{@name}'s turn is up"
    @abilities.each { |key, value| broadcast "#{key}: #{value.name}" }

    key_pressed = gets.chomp.downcase

    if @abilities.has_key?(key_pressed)
      action = @abilities[key_pressed]

      if action.arity == 0
        action.call
      else
        action.call enemies
      end
    else
      act(enemies)
    end
  end
end
