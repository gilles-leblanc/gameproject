require_relative '../broadcast'
require_relative 'paper_doll'

# This is the base character class on which all other character class are based; knight, sorcerer, etc.
class BaseClass
	include Broadcast

	attr_accessor :xp

	attr_reader :name, :level, :hp, :sp, :condition, :paper_doll
	
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
		#@abilities["a"] =
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
		@paper_doll.shield.armor_value + @paper_doll.armor.armor_value
	end

	def act(enemies)
		key_pressed = gets.chomp.downcase
		
		case key_pressed
		when 'a'
			attack(enemies.select {|m| m.hp > 0}.shuffle.first)
		else
			act(enemies)
		end
	end
	
	def attack(target)
		if (1..10).to_a.shuffle.first + @accuracy / 4 >= target.ac
			broadcast "#{@name} hits #{target.name}."
			target.take_damage(@paper_doll.weapon.hit)
		else
			broadcast "#{@name} misses #{target.name}."
		end
		
		broadcast ""
	end
	
	def block
		
	end
	
	def run
	
	end
end
