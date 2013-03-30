class Armor
	attr_reader :name, :armor_value, :category

	def initialize(name, armor_value)
		@name = name
		@armor_value = armor_value
	end
	
protected

	def self.null_object
		null_object_armor = Armor.new("", 0)
	end
end

class PaddedArmor < Armor
	def initialize
		@name = "Padded armor"
		@armor_value = 2
		@category = :very_light
	end
end

class LeatherArmor < Armor
	def initialize
		@name = "Leather Armor"
		@armor_value = 3
		@category = :light
	end
end
	
