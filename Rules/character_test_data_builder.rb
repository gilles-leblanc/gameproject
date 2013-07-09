require_relative './stats'
require_relative './base_class'

class CharacterTestDataBuilder
	def initialize
		@name = "Felgar"
		@armor_categories = [:very_light]
		
		@stats = Stats.new
    @stats.might, @stats.accuracy, @stats.endurance, @stats.intellect, @stats.personality, @stats.speed, @stats.luck = 10, 10, 10, 10, 10, 10, 10
	end
	
	def build
		character = BaseClass.new(@name, @stats)
		character.paper_doll.armor_categories = @armor_categories
		character
	end
	
	def with_name(name)
		@name = name
		self
	end
	
	def with_armor_categories(armor_categories)
		@armor_categories = armor_categories
		self
	end
end
