require_relative '../broadcast'
require_relative 'paper_doll'
require_relative 'actions'
require_relative 'effects'

# This is the base character class on which all other character class are based; knight, sorcerer, etc.
class BaseClass
	include Broadcast, Actions

	attr_accessor :xp

	attr_reader :name, :level, :hp, :sp, :effects, :paper_doll
	
	# basic stats
	attr_reader :might, :accuracy, :endurance, :intellect, :personality, :speed, :luck
	
	def initialize(name, stats)
		@level = 1
		@sp = 0		
		@ac = 0
		@xp = 0
		@name = name
		
		@paper_doll = PaperDoll.new
		@paper_doll.armor_categories = [:very_light]
		@paper_doll.weapon_categories = [:simple]
		
		@might = stats.might
		@accuracy = stats.accuracy
		@speed = stats.speed

		@abilities = Hash.new
		@abilities["a"] = self.method(:attack)
    @abilities["b"] = self.method(:block)
    @abilities["p"] = self.method(:pass)

    @effects = { :ac => [], :might => [], :accuracy => [], :endurance => [],
                 :intellect => [], :personality => [], :speed => [], :luck => [] }
	end 
		
	def take_damage(hp)
		@hp -= hp
		broadcast "#{@name} takes #{hp} points of damage."
		broadcast "#{@name} is defeated." if @hp <= 0		
		broadcast ""
	end
	
	def heal(hp)
		@hp += hp
	end
	
	# Level (verb, not the noun) the character by one new level.	
	def level
		@level += 1
		new_hp = @hp_per_level + @endurance / 4
		@hp += new_hp
		broadcast "#{@name} gains #{new_hp} hp."
	end
	
	def ac
    effects_ac_modifier = @effects[:ac].inject(0) { |sum, x| sum + x[0] }
    if effects_ac_modifier.nil? then effects_ac_modifier = 0 end

		@paper_doll.shield.base_armor_value +
        @paper_doll.armor.armor_value +
        effects_ac_modifier
  end

	def act(enemies)
    Effects.update_effects_timers(@effects)

    broadcast "#{@name}'s turn is up"
    @abilities.each {|key, value| broadcast "#{key}: #{value.name}"}

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
