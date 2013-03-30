require_relative '../broadcast'
require_relative '../treasure_table'

class Goblin
	include Broadcast

	attr_reader :name, :speed, :xp
	attr_accessor :hp, :ac
	
	def initialize
		@name = "Goblin"
		@hp = 4 + [0, 1, 2].shuffle.first
		@ac = 6
		@xp = 5
		
		@speed = 12
		
		@accuracy_bonus = 2
	end
	
	def attack(target)
		if [0, 1, 2, 3].shuffle.first + @accuracy_bonus >= target.ac
			broadcast "#{@name} hits #{target.name}."
			target.take_damage((2..4).to_a.shuffle.first)
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
		TreasureTable.generate_a
	end
end
